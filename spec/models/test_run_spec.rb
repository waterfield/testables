require 'spec_helper'

describe TestRun do
  subject { TestRun.new }
  its(:dummy) { should == 'dummy' }
end
