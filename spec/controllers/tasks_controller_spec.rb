require 'spec_helper'

describe TasksController do

  let(:contents) {{ type: 'rspec', url: 'git@github.com:foo/bar.git' }}

  # Route /tasks/claim
  specify do
    { post: '/tasks/claim' }.should route_to(
      controller: 'tasks',
      action: 'claim' )
  end

  # Route /tasks
  specify do
    { get: '/tasks' }.should route_to(
      controller: 'tasks',
      action: 'index' )
  end

  # Route /tasks/:id
  specify do
    { put: '/tasks/id' }.should route_to(
      controller: 'tasks',
      action: 'update',
      id: 'id' )
  end

  it 'returns not_found when the queue is empty' do
    post :claim, format: :json
    assert_response :not_found
  end

  context 'when claiming a task' do
    before do
      @task = Task.create!
      post :claim, owner: 'worker-1', format: :json
    end

    describe 'the response' do
      subject { JSON.parse(response.body).with_indifferent_access }
      it { should include(state: 'claimed', owner: 'worker-1') }
    end

    describe 'the task' do
      subject { @task.reload }
      its(:state) { should == 'claimed' }
      its(:owner) { should == 'worker-1' }
    end
  end

  context 'when requesting the wrong content type' do
    before { get :index }
    specify { response.code.should == '406' }
  end

  context 'when finishing a task' do
    before do
      @task = Task.create! state: 'claimed'
      put :update, id: @task.id, results: 'w00t'
    end

    describe 'the task' do
      subject { @task.reload }
      its(:state) { should == 'finished' }
      its(:results) { should == 'w00t' }
    end
  end

end
