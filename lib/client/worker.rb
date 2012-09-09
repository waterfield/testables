require 'client/task'

module Client

  # The worker executes a sequence of tasks from
  # the queue. When the queue is exhausted, it waits
  # for a time (default 5 seconds) until asking again,
  # since we're using short polling.
  class Worker
    include ActionView::Helpers::DateHelper

    def initialize(opts = {})
      @wait_period = opts[:wait_period] || 5
    end

    # This function never terminates.
    def run
      while true
        if task = next_task
          notify { task.handle }
        else
          sleep @wait_period
        end
      end
    end

  private

    # Grab the next task with GET /tasks/claim?owner=...
    # Also, set the 'id' parameter of the resulting model
    # so that +Her+ doesn't get confused.
    def next_task
      task = ::Client::Task.claim(owner: owner)
      task.id = task._id
      task
    rescue
      nil # indicates ._id wasn't found
    end

    # The owner is named after "worker-{pid}" and is used
    # to uniquely idenfity who a task belongs to.
    def owner
      @owner ||= "worker-#{$$}"
    end

    # Time how long the task takes, and print a message
    # when it's done.
    def notify
      start = Time.now
      yield
      finish = Time.now

      time = finish.to_s :db
      elapsed = distance_of_time_in_words start, finish
      seconds = (finish - start).round 2

      puts "#{owner} [#{time}] Completed task in #{elapsed} (#{seconds}s)"
    end
  end
end
