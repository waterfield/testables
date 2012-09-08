class PushesController < ApplicationController
  respond_to :json

  def create
    push = Push.new JSON.parse(params[:payload])
    if push.save
      respond_with push, status: :created
    else
      respond_with push.errors, status: :unprocessable_entity
    end
  end
end
