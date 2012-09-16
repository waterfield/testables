require 'scope_machine'

class Task
  include Mongoid::Document
  include ScopeMachine

  belongs_to :suite
  belongs_to :test_run

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
    after_transition :on => :time_out, :do => :clear_owner
  end

  # When the task is finished, create a TestRun to
  # record the result.
  def record_result
    case contents[:type]
    when 'rspec_suite'
      suite.start_tests result[:files] if result[:files]
    when 'rspec_test'
      test_run.finish_tests self
    end
  end

  def clear_owner
    update_attributes! owner: nil
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
