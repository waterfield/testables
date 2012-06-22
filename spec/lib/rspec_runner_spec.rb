require 'spec_helper'
require 'rspec_runner'

describe RspecRunner do
  
  let(:url) { 'git@github.com:foo/bar.git' }
  let(:task) {{ type: 'rspec', url: url }}
  
  subject { RspecRunner.new }
  its(:prep_command) { should == "bundle install" }
  its(:test_command) { should == "bundle exec rspec" }
  
end