require 'client/test_runner'

module Client

  # This test runner does a bundle install
  # followed by a run of the rspec tests.
  class RspecRunner < TestRunner

    def run_test
      sh "bundle install",
         "bundle exec rspec"
    end

  end
end
