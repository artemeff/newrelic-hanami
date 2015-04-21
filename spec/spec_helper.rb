$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'lotus/controller'
require 'newrelic_rpm'
require 'newrelic-lotus'

RSpec.configure do |config|
  config.before(:suite) do
    DependencyDetection.detect!
  end
end
