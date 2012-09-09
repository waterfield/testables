module Client

  # This is the toplevel class for running tasks in a
  # `Worker` process.
  class Runner
    attr_reader :contents

    def initialize contents
      @contents = contents.with_indifferent_access
    end

    # Subclasses can refine this result with their own
    # result keys.
    def result
      {
        raw_output: raw_output,
        ran_at: Time.now
      }
    end

    # This method should be provided by implementers
    # subclassing `Runner`. This method should just execute
    # the body of the task.
    def run
      raise NotImplemented
    end

    class << self

      # For the given task blob, construct an instance
      # of the appropriate runner class.
      def build contents
        runner_class(contents[:type]).new contents
      end

    private

      def runner_class type
        "Client::#{type.classify}Runner".constantize
      end
    end

  protected

    # Append to this to add output to the result
    # at `result[:raw_output]`.
    def raw_output
      @raw_output ||= ''
    end

    # Execute a sequence of shell commands. Execution halts
    # on any failing command. All commands and their output
    # are added to `raw_output`, separated by a blank line.
    # `sh` returns true if all commands were successful.
    def sh *cmds
      cmds.all? do |cmd|
        raw_output << prompt(cmd) << exec(cmd) << "\n"
        $?.success?
      end
    end

  private

    # Execute the given command in such a way that signals
    # sent to the parent process are NOT propagated to the
    # child process. This way, we can receive SIGINT and
    # gracefully shut down without messing up git or RSpec
    # or whatever.
    def exec cmd
      r, w = IO.pipe
      pid = spawn cmd, pgroup: true, [:out, :err] => w
      w.close
      Process.wait pid
      r.read
    end

    def prompt cmd
      "worker> #{cmd}\n"
    end

  end
end

