require 'spec_helper'

describe Push do

  context 'when created from payload' do
    let(:payload) {File.read(Rails.root.join("spec", "fixtures", "payload.json"))}
    subject { Push.new JSON.parse(payload) }
    its(:repository_name) { should == "defunkt/github" }
  end

  context 'when created for a matching project' do

    before do
      Project.create! repository: 'owner/repo'
      Push.create! repository: {
        'name' => 'repo',
        'owner' => {'name' => 'owner'}}
    end

    it 'should create a task' do
      Task.count.should == 1
      task = Task.first
      task.state.should == 'queued'
      task.contents.should == {
        'url' => 'git@github.com:owner/repo.git',
        'type' => 'rspec'
      }
    end
  end

end
