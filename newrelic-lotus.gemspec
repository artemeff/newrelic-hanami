lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'newrelic-lotus/version'

Gem::Specification.new do |spec|
  spec.name          = 'newrelic-lotus'
  spec.version       = NewRelic::Lotus::VERSION
  spec.authors       = ['Yuri Artemev']
  spec.email         = ['i@artemeff.com']

  spec.summary       = %q{Gem for connecting NewRelic and Lotus}
  spec.homepage      = 'https://github.com/artemeff/newrelic-lotus'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'newrelic_rpm'
  spec.add_runtime_dependency 'lotus-controller', '~> 0.4.0'

  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
end
