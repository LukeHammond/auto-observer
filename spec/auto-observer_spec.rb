require 'spec_helper'

describe AutoObserver do
  context "included in a class with auto observing enabled for a method called tickle" do
    before(:all) do
      class Client
        include AutoObserver

        attr_accessor :before_visit, :after_visit

        auto_observer_callbacks :tickle, :only => [:after, :before]

        def tickle
          "giggle"
        end

        before_tickle :pre_tickle_processing
        after_tickle :post_tickle_processing

        def before_visit
          @before_visit ||= [ ]
        end

        def after_visit
          @after_visit ||= [ ]
        end

        def pre_tickle_processing
          before_visit << :pre_tickle_processing
        end

        def post_tickle_processing
          after_visit << :post_tickle_processing
        end

        include AutoObserver::AliasMethodBind
      end
      
      class ClientObserver < ActiveModel::Observer
        def before_tickle(client)
          client.before_visit << :before_tickle
        end
      end

      class AnotherClientObserver < ActiveModel::Observer
        observe :client
        def before_tickle(client)
          client.before_visit << :before_another_tickle
        end
        
        def after_tickle(client)
          client.after_visit << :after_another_tickle
        end
      end
      
      Client.observers = :client_observer, :another_client_observer
      Client.instantiate_observers
      
    end

    subject { Client.new }
  
    it { should respond_to(:tickle_without_notifications) }
    it { should respond_to(:tickle_with_notifications) }
    it { should respond_to(:tickle_without_run_callbacks) }
    it { should respond_to(:tickle_with_run_callbacks) }
    it { should respond_to(:run_callbacks) }

    its(:class) { should respond_to(:auto_observer_callbacks)} 
    its(:class) { should respond_to(:before_tickle) }
    its(:class) { should_not respond_to(:around_tickle) }
    its(:class) { should respond_to(:after_tickle) }
    
    its(:tickle) { should eql "giggle"}
    
    it "should trigger before observers and callbacks" do
      expect { subject.tickle }.to change { subject.before_visit }.from([ ]).to([ :before_tickle, :before_another_tickle, :pre_tickle_processing ])
    end

    it "should trigger after observers and callbacks" do
      expect { subject.tickle }.to change { subject.after_visit }.from([ ]).to([ :post_tickle_processing, :after_another_tickle ])
    end
  end
end