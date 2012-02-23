require "auto-observer/version"
require 'auto-observer/observing'
require 'auto-observer/callbacks'
require 'auto-observer/callbacks_helper'

module AutoObserver
  extend ActiveSupport::Concern
  included do
    extend ActiveModel::Callbacks
    include AutoObserver::Callbacks if defined?(AutoObserver::Callbacks)
    include AutoObserver::Observing if defined?(AutoObserver::Observing)
  end
end