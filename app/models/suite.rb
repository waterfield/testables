class Suite
  include Mongoid::Document

  field :name, type: String

  belongs_to :project

  has_many :test_runs
  has_many :tasks

  validates_presence_of :name

  def task
    project.task.merge type: 'rspec'
  end

  def test!
    tasks.create! contents: task
  end

  def finish task
    test_runs.create! task.result
  end

end
