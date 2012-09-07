class Task
  include Mongoid::Document

  belongs_to :project

  field :contents, :type => Hash
  field :result, :type => Hash

  state_machine :initial => :queued do
    event :claim do
      transition :queued => :claimed
    end

    event :finish do
      transition any => :finished
    end

    event :time_out do
      transition :claimed => :queued
    end

    after_transition :on => :finish, :do => :record_result
  end

  def record_result
    TestRun.create!(
      ran_at: result['ran_at'],
      passed: result['passed'],
      project_name: project.name,
      raw_output: result['raw_output']
    )
  end

  class << self

    # Claim a task by finding one with no owner and
    # atomically setting the owner to the one provided.
    def claim owner
      while task = where(owner: nil).first
        where(_id: task.id, owner: nil).update_all(owner: owner)
        return task if task.reload.owner == owner
      end
    end

    def enqueue project, contents
      create!(
        project: project,
        status: 'unstarted',
        contents: contents
      )
    end
  end
end
