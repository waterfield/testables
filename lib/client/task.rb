require 'client/runner'
require 'client/rspec_runner'
require 'client/shell_runner'

module Client

  # This is the client side of the `Task` model.
  # Tasks are retrieved using "GET /tasks/claim",
  # which atomically marks a task as belonging to
  # this worker. Then, when complete, they are submittd
  # by updating the task with a status of 'finished'
  # and a 'result' from the `Runner`. The update is
  # to "PUT /tasks/:_id".
  class Task
    include Her::Model

    custom_post :claim

    # Construct a `Runner` and use its result to populate
    # the task, then submit the changes.
    def handle
      runner = Runner.build(contents)
      runner.run
      self.result = runner.result
      save
    end
  end
end
