require 'spec_helper'

describe TasksController do
  
  context 'should return a task' do
    before do
      get :index, format: :json
    end
    
    specify do
      response.status.should == 200
    end
  end
end