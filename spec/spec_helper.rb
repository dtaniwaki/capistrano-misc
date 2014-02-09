require 'rubygems'
require 'bundler/setup'

if ENV["COVERAGE"]
  require 'simplecov'
  SimpleCov.start do
    add_filter do |src|
      src.filename !~ /#{File.join(root, 'lib')}\//
    end
  end
end

require 'capistrano'
Capistrano::Configuration.instance = Capistrano::Configuration.new
require 'capistrano-misc'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each{ |f| require f }

RSpec.configure do |config|
  config.color_enabled = true
  config.before :each do
    configuration.logger = Capistrano::Logger.new(:output => '/dev/null')
  end
end

