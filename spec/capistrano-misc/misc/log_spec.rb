require 'spec_helper'

describe CapistranoMisc::Misc::Log, 'add tail task' do
  let :configuration do
    configuration = Capistrano::Configuration.new
    CapistranoMisc::Misc::Log.load_into(configuration)
    configuration.extend Capistrano::Spec::ConfigurationExtension
    configuration.set :current_path, 'current'
    configuration
  end

  before do
    ENV['target'] = nil
  end

  it 'should output tail' do
    configuration.stub_command("tail -f current/log/*.log", data: 'hit!')
    STDOUT.should_receive(:puts).with('hit!')
    STDOUT.should_receive(:puts).with(no_args)
    configuration.find_and_execute_task('misc:log')
  end

  it 'should set target file' do
    ENV['file'] = 'sample.txt'
    configuration.should_receive(:run).with("tail -f current/log/sample.txt")
    configuration.find_and_execute_task('misc:log')
  end
end
