class TasksController < ApplicationController
  respond_to :json
  expose(:tasks) {Task.scoped}
  expose :task
  before_filter :parse_task_param, only: :update
  
  def index
    respond_with tasks
  end
  
  def pop
    task = tasks.unstarted.first
    if task.present?
      respond_with task
    else
      respond_with nil, status: :not_found
    end
  end
  
  def update
    if task.save
      respond_with task
    else
      respond_with task.errors, :status => :unprocessable_entity
    end
  end
  
  private
  
  def parse_task_param
    params[:task] = JSON.parse(params[:task])
  end
end
