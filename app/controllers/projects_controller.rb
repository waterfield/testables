class ProjectsController < ApplicationController

  expose(:projects) { Project.scoped }
  expose :project

  def create
    if project.save
      flash[:notice] = "Created project!"
      redirect_to project
    else
      flash.now[:warn] = "Failed to craete project."
      render action: :new
    end
  end
end
