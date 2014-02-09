require 'spec_helper'

describe CapistranoMisc::Misc::Tailf, 'add tail task' do
  let :configuration do
    configuration = Capistrano::Configuration.new
    CapistranoMisc::Misc::Tailf.load_into(configuration)
    configuration.extend Capistrano::Spec::ConfigurationExtension
    configuration.set :current_path, 'current'
    configuration
  end

  before do
    ENV['tailf_file'] = nil
  end

  it 'should output tail' do
    configuration.stub_command("tail -f current/log/*.log", data: 'hit!')
    STDOUT.should_receive(:puts).with('hit!')
    STDOUT.should_receive(:puts).with(no_args)
    configuration.find_and_execute_task('misc:tailf')
  end

  it 'should set target file by argv' do
    ENV['tailf_file'] = 'sample.txt'
    configuration.should_receive(:run).with("tail -f current/log/sample.txt")
    configuration.find_and_execute_task('misc:tailf')
  end

  it 'should set target file by set variable' do
    configuration.should_receive(:run).with("tail -f current/log/sample.out")
    configuration.set :tailf_file, 'sample.out'
    configuration.find_and_execute_task('misc:tailf')
  end

  it 'should set log dir' do
    configuration.should_receive(:run).with("tail -f /glog/*.log")
    configuration.set :tailf_dir, '/glog'
    configuration.find_and_execute_task('misc:tailf')
  end
end
