require 'client/runner'
require 'client/git_commands'

module Client

  # This runner checks out the repository so it can analyze
  # the tests, breaking them into parts so that later tasks
  # can be created.
  class RspecSuiteRunner < Runner
    include GitCommands

    def run
      if clone_repo
        Dir.chdir(path) do
          analyze_repo
        end
      else
        raw_output << "Can't clone repo! Aborting."
      end
    end

    def analyze_repo
      @files = Dir['spec/**/*_spec.rb']
    end

    # Include `files` in the result.
    def result
      super.merge files: @files
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
