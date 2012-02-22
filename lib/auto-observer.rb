require "auto-observer/version"

module AutoObserver
  extend ActiveSupport::Concern
  included do

    class_eval(<<-EOS, __FILE__, __LINE__ + 1)
      extend ActiveModel::Callbacks
      include AutoObserver::Callbacks if defined?(AutoObserver::Callbacks)
      include AutoObserver::Observing if defined?(AutoObserver::Observing)
    EOS
  end
end
require 'auto-observer/observing'
require 'auto-observer/callbacks'