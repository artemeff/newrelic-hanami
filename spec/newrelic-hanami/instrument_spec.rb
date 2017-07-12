describe NewRelic::Agent::Instrumentation::Hanami do
  subject do
    NewRelic::Agent::Instrumentation::ControllerInstrumentation
  end

  before do
    stub_const 'Web::Controllers::Home::Index', Class.new
    Web::Controllers::Home::Index.class_eval do
      include Hanami::Action

      def call(params)
        self.body = 'hello'
      end
    end
  end

  it 'perform_action_with_newrelic_trace' do
    expect_any_instance_of(subject).to receive(
      :perform_action_with_newrelic_trace)
    code, headers, body = Web::Controllers::Home::Index.new.call({})

    expect(code).to    eq(200)
    expect(headers).to eq({})
    expect(body).to    eq(['hello'])
  end
end
