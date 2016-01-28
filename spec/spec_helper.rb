$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'hanami/controller'
require 'newrelic_rpm'
require 'newrelic-hanami'

RSpec.configure do |config|
  config.before(:suite) do
    DependencyDetection.detect!
  end
end
