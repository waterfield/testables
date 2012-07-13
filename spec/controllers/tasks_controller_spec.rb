require 'spec_helper'

describe TasksController do
  
  let(:contents) {{ type: 'rspec', url: 'git@github.com:foo/bar.git' }}
  let(:date) { date ||= DateTime.now.to_s }
  
  specify do
    {get: '/tasks/pop'}.should route_to(
      controller: 'tasks',
      action: 'pop'
    )
  end
  
  it 'returns not_found when popping from an empty queue' do
    get :pop, format: :json
    assert_response :not_found
  end
  
  it 'returns the first unstarted task' do
    task = Task.create! status: "unstarted"
    get :pop, format: :json
    response.body.should == task.to_json
  end
  
  context 'when requesting the wrong content type' do
    before { get :index }
    specify { response.code.should == '406' }
  end
  
  context 'when updating status of a task' do
    let(:task) {Task.create! status: "started"}
    before do
      put :update,
        format: 'json',
        id: task.id,
        task: {
          status: "finished",
          result: {"foo" => 2}
        }.to_json
    end
    specify do
      task.reload
      task.status.should == "finished"
      task.result.should == {"foo" => 2}
    end
  end
end