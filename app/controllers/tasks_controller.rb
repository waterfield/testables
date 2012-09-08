class TasksController < ApplicationController

  resource_description do
    name 'Tasks'
    short 'Task Bag'
    path '/tasks'
    version '1.0'
    formats ['json']
  end

  respond_to :json

  before_filter :parse_task_param, only: :update
  expose(:tasks) { Task.scoped }
  expose :task

  api :GET, "/", "Get a list of all tasks"
  def index
    respond_with tasks
  end

  api :POST, "/claim", "Claim a queued task"
  param :owner, String, :desc => "Unique string to identify task owner", :required => true
  def claim
    if task = Task.claim(params[:owner])
      render json: task
    else
      render json: {}, status: :not_found
    end
  end

  api :PUT, "/task/:id", "Complete a task"
  param :id, String, :desc => "Task id", :required => true
  param :result, Hash, :desc => "Results of task run", :required => true
  param :ran_at, DateTime, :desc => "Time when the task ran", :required => true
  def update
    if task.finish
      render json: task
    else
      render json: {errors: task.errors}, status: :unprocessable_entity
    end
  end

  private

  def parse_task_param
    task = params.reject do |key, v|
      %w(id controller action).include? key
    end
    params[:task] = task
  end
end
