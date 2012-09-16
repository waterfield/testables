require 'client/test_runner'

module Client

  # This test runner does a bundle install
  # followed by a run of the rspec tests.
  class RspecTestRunner < TestRunner

    def run_test
      sh("bundle install",
         "bundle exec rspec #{opts} #{args}").tap do
        @output = JSON.parse File.read(output_file) rescue nil
      end
    end

  private

    def output_file
      './tmp/rspec_out.json'
    end

    def opts
      "--format json --out #{output_file}"
    end

    def args
      contents[:files].join ' '
    end
  end
end
