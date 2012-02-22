module AutoObserver
  module Callbacks
    extend ActiveSupport::Concern
    include ActiveModel::Callbacks

    included do
      define_model_callbacks *self::CALLBACKS

      self::CALLBACKS.each do |method|
        class_eval(<<-EOS, __FILE__, __LINE__ + 1)
          def #{method}_with_run_callbacks(*args, &block)
            result = nil
            run_callbacks(:#{method}) do
              #{method}_without_run_callbacks(*args, &block)
            end
          end
        EOS
        alias_method_chain(method, :run_callbacks)
      end
    end
  end
end
