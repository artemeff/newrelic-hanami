require 'new_relic/agent/instrumentation'
require 'new_relic/agent/instrumentation/controller_instrumentation'
require 'hanami/controller'
require 'rack'

module NewRelic
  module Agent
    module Instrumentation
      module Hanami
        include ControllerInstrumentation
        NAME_REGEX = /Controllers::/.freeze

      protected

        def finish
          perform_action_with_newrelic_trace(_trace_options) do
            super
          end
        end

      private

        # providing :class_name and :name produces 'Web::User#Get' for the transaction naming
        def _trace_options
          {
            category:   :controller,
            class_name: trace_class_name,
            name:       trace_method_name,
            request:    request,
            params:     params.to_h
          }
        end

        ## like 'Web::User::Get' => ['Web','User','Get']
        def trace_controller_names
          @trace_controller_names ||= self.class.name.sub(NAME_REGEX, '').split('::')
        end

        ## 'Get'
        def trace_method_name
          trace_controller_names.last
        end

        ## 'Web::User'
        def trace_class_name
          trace_controller_names[0...-1].join('::')
        end

      end
    end
  end
end

DependencyDetection.defer do
  @name = :hanami

  depends_on do
    defined?(::Hanami) &&
      !::NewRelic::Control.instance['disable_hanami'] &&
      !ENV['DISABLE_NEW_RELIC_HANAMI']
  end

  executes do
    NewRelic::Agent.logger.info 'Installing Hanami instrumentation'
  end

  executes do
    ::Hanami::Controller.configure do
      prepare do
        include ::NewRelic::Agent::Instrumentation::Hanami
      end
    end
  end
end
