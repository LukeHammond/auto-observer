module AutoObserver
  module Observing
    extend ActiveSupport::Concern
    include ActiveModel::Observing

    included do
      self.callbacks_each do |method|
        define_method("#{method}_with_notifications") do |*args, &block|
          notify_observers("before_#{method}")
          if result = send("#{method}_without_notifications", *args, &block)
            notify_observers("after_#{method}")
          end
          result
        end
      end
    end
  end
end