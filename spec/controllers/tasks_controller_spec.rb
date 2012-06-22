require 'spec_helper'

describe TasksController do
  
  specify do
    {get: '/tasks'}.should route_to(
      controller: 'tasks',
      action: 'index'
    )
  end
  
  context 'should return a task' do
    before do
      get :index, format: :json
    end
    
    specify do
      JSON.parse(response.body).should == {
        'type' => "rspec",
        'url' => "git@github.com:waterfield/testables.git"
      }
    end
  end
  
  context 'when requesting the wrong content type' do
    before { get :index }
    specify { response.code.should == '406' }
  end
end