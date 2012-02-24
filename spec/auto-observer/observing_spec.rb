require 'spec_helper'

describe "AutoObserver::Observing" do
  context "included in a class with observing enabled for a method called tickle" do
    before do
      class ClientClass
        @callbacks = [:tickle]
      
        def tickle
        end
      end
      ClientClass.send(:extend, ActiveModel::Callbacks)
      ClientClass.send(:include, AutoObserver::Observing)
    end

    subject { ClientClass.new }
  
    it { should respond_to(:tickle_without_notifications) }
    it { should respond_to(:tickle_with_notifications) }
    
    its(:class) { should respond_to(:before_tickle) }
    its(:class) { should respond_to(:after_tickle) }
    
  end
end