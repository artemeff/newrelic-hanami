require 'new_relic/agent/instrumentation'
require 'new_relic/agent/instrumentation/controller_instrumentation'
require 'hanami/controller'
require 'rack'

module NewRelic
  module Agent
    module Instrumentation
      module Hanami
        include ControllerInstrumentation

      protected

        def finish
          perform_action_with_newrelic_trace(_trace_options) do
            super
          end
        end

      private

        def _trace_options
          {
            category: :controller,
            name:     self.class.name.gsub('Controllers::', ''),
            request:  request,
            params:   params.to_h
          }
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
