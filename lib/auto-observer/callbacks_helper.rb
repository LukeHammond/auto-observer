module AutoObserver
  module CallbacksHelper

    ## Define ModelMethods
    module Base
      def self.included(klass)
        klass.class_eval do
          extend ClassMethods
        end
      end
      
      module ClassMethods
        def auto_observer_callbacks(*args)
          options = args.extract_options!
          @callbacks = args
          define_model_callbacks *@callbacks, options
        end
      end
    end
  end
end
