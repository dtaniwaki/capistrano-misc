# capistrano-misc

[![Gem Version](https://badge.fury.io/rb/capistrano-misc.png)](https://rubygems.org/gems/capistrano-misc) [![Build Status](https://travis-ci.org/dtaniwaki/capistrano-misc.png)](https://travis-ci.org/dtaniwaki/capistrano-misc)

capistrano-misc provides some useful tasks for Capistrano 2.

## Installation

Add the library to your ```Gemfile```
```ruby
group :development do
  gem 'capistrano-misc', :require => false
end
```

And load it into your deployment script ```config/deploy.rb```
```ruby
require 'capistrano-misc'
```

## Tasks

Execute tasks
```ruby
cap misc:tailf
```

Add task hooks
```ruby
after 'multistage:ensure', 'misc:guard'
set :guard_env, [:production, :beta] # default :production

before 'deploy:update_code', 'misc:branch'
set :branch, /upstream.*\/master$/ # default all
```

## Contributing

See the [contributing guide](https://github.com/dtaniwaki/capistrano-misc/blob/master/CONTRIBUTING.md).

## Copyright

Copyright (c) 2014-2014 Daisuke Taniwaki. See [LICENSE](https://github.com/dtaniwaki/capistrano-misc/blob/master/LICENSE) for details.
