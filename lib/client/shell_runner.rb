require 'client/runner'

module Client

  # This runner just executes a sequence of
  # shell commands using `sh` and sets
  # `result[:status]` to whether the sequence
  # was successful.
  class ShellRunner < Runner

    def run
      @status = sh *contents[:commands]
    end

    def result
      super.merge status: @status
    end
  end
end
