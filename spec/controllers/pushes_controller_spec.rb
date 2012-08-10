require 'spec_helper'

describe PushesController do
  let(:payload) {File.read(Rails.root.join("spec", "fixtures", "payload.json"))}

  it 'should route to create action' do
    {post: "/pushes"}.should route_to(controller: "pushes", action: "create")
  end

  context 'when pushing commits from github' do
    before { post :create, payload: payload }
    subject { Push.first }
    it { should_not be_nil }
    it 'should have the correct attributes' do
      attrs = subject.attributes
      attrs.delete '_id'
      attrs.should == JSON.parse(payload)
    end
  end

end
