require 'spec_helper'

describe CapistranoMisc::Misc::Branch, 'add branch select' do
  let :configuration do
    configuration = Capistrano::Configuration.new
    CapistranoMisc::Misc::Branch.load_into(configuration)
    configuration.task('deploy:update_code') {}
    configuration.before 'deploy:update_code', 'misc:branch'
    configuration.stub(:scm).and_return('git')
    configuration
  end

  it 'should skip select deploy branch' do
    configuration.should_not_receive(:run_locally)
    configuration.set :branch, 'something'
    configuration.send('deploy:update_code')
  end

  it 'should let you select deploy branch' do
    configuration.should_receive(:run_locally).and_return("branch1\nbranch2")
    Capistrano::CLI.ui.should_receive(:ask).with("Choose branch from \n0: Use revision number\n1: branch1\n2: branch2\nq: Quit\n or type tag to deploy (make sure to push the tag first): ").and_return('1')
    configuration.send('deploy:update_code')
  end

  it 'should let you select revision directly' do
    configuration.should_receive(:run_locally).and_return("")
    Capistrano::CLI.ui.should_receive(:ask).with("Choose branch from \n0: Use revision number\nq: Quit\n or type tag to deploy (make sure to push the tag first): ").and_return('0')
    Capistrano::CLI.ui.should_receive(:ask).with('Type revision or tag to deploy: ').and_return('abcd')
    configuration.send('deploy:update_code')
  end

  it 'should quit by typing q' do
    configuration.should_receive(:run_locally).and_return("branch1\nbranch2")
    Capistrano::CLI.ui.should_receive(:ask).and_return('q')
    expect {
      configuration.send('deploy:update_code')
    }.to raise_error(SystemExit)
  end

  it 'should let you select deploy branch' do
    configuration.should_receive(:run_locally).and_return("branch1\nbranch2")
    Capistrano::CLI.ui.should_receive(:ask).and_return('1')
    configuration.send('deploy:update_code')
    configuration.branch.should == 'branch1'
  end

  it 'should not allow you to deploy specified revisions' do
    configuration.set :branch, /^abc/
    configuration.should_receive(:run_locally).and_return("abc\ndef")
    Capistrano::CLI.ui.should_receive(:ask).with("Choose branch from \n0: Use revision number\n1: abc\nq: Quit\n or type tag to deploy (make sure to push the tag first): ").and_return('0')
    Capistrano::CLI.ui.should_receive(:ask).with('Type revision or tag to deploy: ').and_return('def')
    expect {
      configuration.send('deploy:update_code')
    }.to raise_error(SystemExit)
  end
end
