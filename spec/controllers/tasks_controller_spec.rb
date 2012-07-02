require 'spec_helper'

describe TasksController do

  let(:task) {{ type: 'rspec', url: 'git@github.com:foo/bar.git', run_at: DateTime.now }}
  let(:date) { date ||= DateTime.now.to_s }
  
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
  
  context 'when updating status of a task' do
    before do
      post :done,
        format: 'json',
        task: task,
        success: true,
        passed: true,        
        raw_output: 'Success!',
        ran_at: date
    end
    specify do
      tr = TestRun.where(
        passed: true,
        raw_output: "Success!"
      )
      #.count.should == 1
      tr.count.should >= 1
      tr.last.ran_at.should == date
    end
  end
end