module AutoObserver
  module Callbacks
    extend ActiveSupport::Concern
    include ActiveModel::Callbacks

    included do
      @callbacks.each do |method|
        define_method("#{method}_with_run_callbacks") do |*args, &block|
          run_callbacks("#{method}") do
            send("#{method}_without_run_callbacks", *args, &block)
          end
        end
        
        # class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        #   def #{method}_with_run_callbacks(*args, &block)
        #     result = nil
        #     run_callbacks(:#{method}) do
        #       #{method}_without_run_callbacks(*args, &block)
        #     end
        #   end
        # EOS
        alias_method_chain(method, :run_callbacks)
      end
    end
  end
end
