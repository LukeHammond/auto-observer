require 'active_support'
require 'active_model'
require 'auto-observer/version'
require 'auto-observer/observing'
require 'auto-observer/callbacks'
require 'auto-observer/alias_method_bind'

module AutoObserver
  extend ActiveSupport::Concern

  included do
    extend ActiveModel::Callbacks
    extend ClassMethods
  end

  module ClassMethods

    def auto_observer_callbacks(*args)
      options = args.extract_options!
      @callbacks = args
      define_model_callbacks *@callbacks, options

      include AutoObserver::Callbacks
      include AutoObserver::Observing
    end

    def callbacks_each
      @callbacks.each do |callback|
        yield callback
      end
    end
  end
end