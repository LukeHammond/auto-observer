require 'spec_helper'

describe "AutoObserver::Callbacks" do
  context "included in a class with callbacks enabled for a method called tickle" do
    before do
      class ClientClass
        @callbacks = [:tickle]
      
        def tickle
        end
      end
      ClientClass.send(:extend, ActiveModel::Callbacks)
      ClientClass.send(:include, AutoObserver::Callbacks)
    end

    subject { ClientClass.new }
  
    it { should respond_to(:tickle_without_run_callbacks) }
    it { should respond_to(:tickle_with_run_callbacks) }
    it { should respond_to(:run_callbacks) }
    
    its(:class) { should respond_to(:before_tickle) }
    its(:class) { should respond_to(:after_tickle) }
    
  end
end