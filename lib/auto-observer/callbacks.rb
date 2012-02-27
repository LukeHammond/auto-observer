module AutoObserver
  module Callbacks
    extend ActiveSupport::Concern
    included do
      self.callbacks_each do |method|
        define_method("#{method}_with_run_callbacks") do |*args, &block|
          run_callbacks("#{method}") do
            send("#{method}_without_run_callbacks", *args, &block)
          end
        end
      end
    end
  end
end
