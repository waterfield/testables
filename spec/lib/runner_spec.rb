# require 'spec_helper'
# require 'runner'

# class DummyRunner < Struct.new(:task); end

# describe Runner do

#   let(:url) { 'git@github.com:foo/bar.git' }
#   let(:task) {{ type: 'dummy', url: url }}

#   subject { Runner.new task }

#   context 'when checking out a repository' do
#     it 'should create the right clone command' do
#       command = subject.clone_command 'some_path'
#       command.should == "git clone #{url} some_path"
#     end
#   end

#   context 'when building a new runner' do
#     specify { Runner.runner_class('dummy').should == DummyRunner }
#     subject { Runner.build task }
#     it { should be_a DummyRunner }
#     its(:task) { should == task }
#   end
# end
