require "rubygems"
require "bundler/setup"
require 'rspec/core/rake_task'
require 'appraisal'

RSpec::Core::RakeTask.new(:spec)

task :default => [:all]

task :all do
  Rake::Task['appraisal:install'].execute
  exec('rake appraisal spec')
end

namespace :spec do
  desc "Execute rspec coverage"
  task :coverage do
    ENV['COVERAGE'] = 'true'
    Rake::Task["spec"].execute
  end
end
