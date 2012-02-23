module AutoObserver
  module Observing
    extend ActiveSupport::Concern
    include ActiveModel::Observing

    included do
      @callbacks.each do |method|
        # example
        # def push_with_notifications(*args, &block)
        #   notify_observers(:before_push)
        #   if result = push_without_notifications(*args, &block)
        #     notify_observers(:after_push)
        #   end
        #   result
        # end
        class_eval(<<-EOS, __FILE__, __LINE__ + 1)
          def #{method}_with_notifications(*args, &block)
            notify_observers(:before_#{method})
            if result = #{method}_without_notifications(*args, &block)
              notify_observers(:after_#{method})
            end
            result
          end
        EOS
        alias_method_chain(method, :notifications)
      end
    end
  end
end