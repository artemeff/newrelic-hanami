require 'new_relic/agent/instrumentation'
require 'new_relic/agent/instrumentation/controller_instrumentation'
require 'lotus/controller'

module NewRelic
  module Agent
    module Instrumentation
      module Lotus
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
            path:     "#{request.request_method} #{request.path}",
            request:  request,
            params:   params.to_h
          }
        end
      end
    end
  end
end

DependencyDetection.defer do
  @name = :lotus

  depends_on do
    defined?(::Lotus) &&
      !::NewRelic::Control.instance['disable_lotus'] &&
      !ENV['DISABLE_NEW_RELIC_LOTUS']
  end

  executes do
    NewRelic::Agent.logger.info 'Installing Lotus instrumentation'
  end

  executes do
    ::Lotus::Controller.configure do
      prepare do
        include ::NewRelic::Agent::Instrumentation::Lotus
      end
    end
  end
end
