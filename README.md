### NewRelic Lotus

---

[![Travis](https://img.shields.io/travis/artemeff/newrelic-lotus.svg)]() [![Code Climate](https://codeclimate.com/github/artemeff/newrelic-lotus/badges/gpa.svg)](https://codeclimate.com/github/artemeff/newrelic-lotus)

---

```ruby
gem 'newrelic-lotus'
```

Add it to your `config.ru`:

```ruby
require 'newrelic_rpm'
require 'newrelic-lotus'

NewRelic::Agent.manual_start
```

It should looks like:

```ruby
require './config/environment'
require 'newrelic_rpm'
require 'newrelic-lotus'

NewRelic::Agent.manual_start

run Lotus::Container.new

```

And add `newrelic.yml` to `config` folder.

---

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
