require 'spec_helper'

describe "AutoObserver::Observing" do
  context "included in a class with observing enabled for a method called tickle" do
    before do
      class ClientClass
        include AutoObserver

        auto_observer_callbacks :tickle, :only => [:after, :before]
      
        def tickle; end

        include AutoObserver::AliasMethodBind
      end
    end

    subject { ClientClass.new }
  
    it { should respond_to(:tickle_without_notifications) }
    it { should respond_to(:tickle_with_notifications) }
    
    its(:class) { should respond_to(:before_tickle) }
    its(:class) { should respond_to(:after_tickle) }
    
  end
end