require 'spec_helper'

describe AutoObserver::CallbacksHelper do
  context "included in a class with observing enabled for a method called tickle" do
    before do
      class MyBase; end
      
      MyBase.send(:extend, ActiveModel::Callbacks)
      MyBase.send(:include, AutoObserver::CallbacksHelper::Base)
      
      class ClientClass < MyBase
        auto_observer_callbacks :tickle, :only => [:after, :before]

        def tickle
        end
      end
    end

    subject { ClientClass.new }
  
    its(:class) { should respond_to(:auto_observer_callbacks)} 
    its(:class) { should respond_to(:before_tickle) }
    its(:class) { should respond_to(:after_tickle) }
  end
end