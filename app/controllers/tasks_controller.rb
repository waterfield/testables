class TasksController < ApplicationController

  respond_to :json

  before_filter :parse_task_param, only: :update
  expose(:tasks) {Task.scoped}
  expose :task

  def index
    respond_with tasks
  end

  def claim
    if task = Task.claim(params[:owner])
      render json: task
    else
      render json: {}, status: :not_found
    end
  end

  def update
    if task.save
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
