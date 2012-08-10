class Push
  include Mongoid::Document

  after_create :notify_projects

  def repository_name
    "#{repository['owner']['name']}/#{repository['name']}"
  end

private

  def notify_projects
    Project.notify repository_name
  end
end
