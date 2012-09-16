class TestResult
  include Mongoid::Document

  field :passed, type: Boolean
  field :description, type: String
  field :exception, type: String
  field :backtrace, type: Array

  embedded_in :test_run

  class << self
    def from_rspec example
      opts = {
        passed: example['status'] == 'passed',
        description: example['full_description']
      }

      if exc = example['expection']
        opts.merge! backtrace: exc['backtrace'],
                    exception: exc['message']
      end

      self.new opts
    end
  end
end
