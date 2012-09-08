require 'scope_machine'

class Task
  include Mongoid::Document
  include ScopeMachine

  belongs_to :project

  field :contents, :type => Hash
  field :result, :type => Hash

  # Add a state machine for tasks. They can be in the following
  # states:
  #
  # * queued:   new tasks, waiting to be claimed
  # * claimed:  a task which is in progress
  # * finished: a completed tasks
  state_machine :initial => :queued do
    event(:claim)    { transition :queued  => :claimed  }
    event(:finish)   { transition any      => :finished }
    event(:time_out) { transition :claimed => :queued   }
    after_transition :on => :finish, :do => :record_result
  end

  # When the task is finished, create a TestRun to
  # record the result.
  #
  # TODO: refactor this to do different things based
  # on the task contents.
  def record_result
    project.test_runs.create! result if project
  end

  class << self

    # Claim a task by finding one with no owner and
    # atomically setting the owner to the one provided.
    # If we can't claim the task, try again until no
    # unclaimed tasks are left, then return nil.
    def claim owner
      while task = queued.first
        where(_id: task.id, owner: nil).update_all(owner: owner)
        return task.claim && task if task.reload.owner == owner
      end
    end

  end
end
