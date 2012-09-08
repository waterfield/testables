require 'spec_helper'

describe ProjectsController do

  it 'should route the create action' do
    { post: '/projects' }.should route_to(
      controller: 'projects',
      action: 'create' )
  end

  context 'when creating a project' do
    before do
      post :create,
        project: {
          name: 'test project',
          repository: 'energy/repo' }
    end

    it 'should create the project' do
      Project.count.should == 1
    end
  end
end
