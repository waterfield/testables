class SuitesController < ApplicationController

  expose :project
  expose(:suites) { project.suites }
  expose :suite

  def create
    if suite.save
      flash[:notice] = "Created suite!"
      redirect_to project
    else
      flash.now[:warn] = "Failed to creete suite."
      render action: :new
    end
  end

end
