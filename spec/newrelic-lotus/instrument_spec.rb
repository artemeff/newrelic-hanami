require 'lotus/welcome'

describe NewRelic::Agent::Instrumentation::Lotus do
  subject do
    NewRelic::Agent::Instrumentation::ControllerInstrumentation
  end

  let(:action) do
    Class.new do
      include Lotus::Action

      def call(params)
        self.body = 'hello'
      end
    end
  end

  it 'perform_action_with_newrelic_trace' do
    expect_any_instance_of(subject).to receive(
      :perform_action_with_newrelic_trace)
    code, headers, body = action.new.call({})

    expect(code).to    eq(200)
    expect(headers).to eq({})
    expect(body).to    eq(['hello'])
  end
end
