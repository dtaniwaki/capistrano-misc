# capistrano-misc

[![Gem Version](https://badge.fury.io/rb/capistrano-misc.png)](https://rubygems.org/gems/capistrano-misc) [![Build Status](https://travis-ci.org/dtaniwaki/capistrano-misc.png)](https://travis-ci.org/dtaniwaki/capistrano-misc)

capistrano-misc provides some useful tasks for Capistrano 2.

## Installation

To your system

```ruby
gem install capistrano-misc
```

Or add capistrano-misc to your `Gemfile` and `bundle install`:

```ruby
gem 'capistrano-misc'
```

## Tasks

Execute individual tasks
```ruby
cap misc:log
```

Add callback tasks in ```config/deploy.rb```
```ruby
after 'multistage:ensure', 'misc:guard'
before 'deploy:update_code', 'misc:branch'
```

## Contributing

See the [contributing guide](https://github.com/dtaniwaki/capistrano-misc/blob/master/CONTRIBUTING.md).

## Copyright

Copyright (c) 2014-2014 Daisuke Taniwaki. See [LICENSE](https://github.com/dtaniwaki/capistrano-misc/blob/master/LICENSE) for details.
