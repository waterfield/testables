class TasksController < ApplicationController
  respond_to :json
  
  def index
    # params[:test_types] # indicates what tests the client supports
    # task = Task.unstarted.where(type: params[:test_types])
    # task.start! params[:api_key]
    # respond_with task
    respond_with(
      type: 'rspec',
      url: "git@github.com:waterfield/testables.git"
    )
  end
end