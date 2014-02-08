require 'spec_helper'

describe CapistranoMisc::Misc::Guard, 'add guard callback' do
  let :configuration do
    configuration = Capistrano::Configuration.new
    CapistranoMisc::Misc::Guard.load_into(configuration)
    configuration.task('multistage:ensure') {}
    configuration.after 'multistage:ensure', 'misc:guard'
    configuration
  end

  it 'should have default guard env' do
    configuration.guard_env.to_s.should == 'production'
  end

  it 'should guard a guarded env' do
    configuration.set :guard_env, :guard_env

    configuration.set :rails_env, :guard_env
    Capistrano::CLI.ui.should_receive(:ask).and_return('y')
    configuration.send('multistage:ensure')

    configuration.set :rails_env, :no_guard_env
    Capistrano::CLI.ui.should_not_receive(:ask)
    configuration.send('multistage:ensure')
  end

  it 'should guard multiple guarded envs' do
    configuration.set :guard_env, [:guard_env1, :guard_env2]

    configuration.set :rails_env, :guard_env1
    Capistrano::CLI.ui.should_receive(:ask).and_return('y')
    configuration.send('multistage:ensure')

    configuration.set :rails_env, :guard_env2
    Capistrano::CLI.ui.should_receive(:ask).and_return('y')
    configuration.send('multistage:ensure')

    configuration.set :rails_env, :no_guard_env
    Capistrano::CLI.ui.should_not_receive(:ask)
    configuration.send('multistage:ensure')
  end

  it 'should guard regexp guarded env' do
    configuration.set :guard_env, /^guard_/

    configuration.set :rails_env, :guard_env
    Capistrano::CLI.ui.should_receive(:ask).and_return('y')
    configuration.send('multistage:ensure')

    configuration.set :rails_env, :no_guard_env
    Capistrano::CLI.ui.should_not_receive(:ask)
    configuration.send('multistage:ensure')
  end

  it 'should guard guarded env' do
    configuration.set :guard_env, :guard_env
    configuration.set :rails_env, :guard_env

    Capistrano::CLI.ui.should_receive(:ask).and_return('n')
    expect {
      configuration.send('multistage:ensure')
    }.to raise_error(SystemExit)

    Capistrano::CLI.ui.should_receive(:ask).and_return('y')
    expect {
      configuration.send('multistage:ensure')
    }.not_to raise_error
  end
end
