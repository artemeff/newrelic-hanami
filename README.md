### NewRelic Hanami

---

[![Travis](https://img.shields.io/travis/artemeff/newrelic-hanami.svg)]() [![Code Climate](https://codeclimate.com/github/artemeff/newrelic-hanami/badges/gpa.svg)](https://codeclimate.com/github/artemeff/newrelic-hanami)

---

This gem ingrates in hanami-controller and can be used in full-featured hanami framework and with controller only.

```ruby
gem 'newrelic-hanami'
```

Add it to your `config.ru`:

```ruby
require 'newrelic_rpm'
require 'newrelic-hanami'

NewRelic::Agent.manual_start
```

It should looks like:

```ruby
require './config/environment'
require 'newrelic_rpm'
require 'newrelic-hanami'

NewRelic::Agent.manual_start

run Hanami::Container.new

```

If that doesn't work, include this in your `web/application.rb`:
```
module Web
  class Application < Hanami::Application
    configure do
      ...

      controller.prepare do
        include ::NewRelic::Agent::Instrumentation::Hanami
      end

      ...
    end
  end
end
```


Then add `newrelic.yml` to `config` folder.

---

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
