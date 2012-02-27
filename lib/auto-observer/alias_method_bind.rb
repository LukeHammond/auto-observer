module AutoObserver
  module AliasMethodBind
    extend ActiveSupport::Concern
    included do
      self.callbacks_each do |method|
        alias_method_chain(method, :run_callbacks)
        alias_method_chain(method, :notifications)
      end
    end
  end
end
