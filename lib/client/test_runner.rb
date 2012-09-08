require 'client/runner'
require 'client/git_commands'

module Client

  # The test runner handles checking out the repository
  # before running some kind of test script provided by
  # a subclass. The `run_test` method should execute the
  # test and return whether the test passed.
  class TestRunner < Runner
    include GitCommands

    # Include `passed` in the result.
    def result
      super.merge passed: @passed
    end

    # Clone the repository, then call the `run_test`
    # method in the context of the temporary directory.
    def run
      if clone_repo
        Dir.chdir(path) do
          @passed = run_test
        end
      else
        raw_output << "Can't clone repo! Aborting."
      end
    end

  private

    # The location of the temporary folder to check
    # out the repo.
    def path
      Rails.root.join 'tmp/checkout'
    end

    def url
      contents[:url]
    end
  end
end
