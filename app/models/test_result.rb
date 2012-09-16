class TestResult
  include Mongoid::Document

  field :passed, type: Boolean
  field :description, type: String
  field :exception, type: String
  field :backtrace, type: Array

  embedded_in :test_run

  class << self
    def from_rspec example
      desc = example['description'].strip
      full = example['full_description'].strip
      full << ' ' << desc unless full.ends_with? desc

      opts = {
        passed: example['status'] == 'passed',
        description: full
      }

      if exc = example['exception']
        opts.merge! backtrace: exc['backtrace'],
                    exception: exc['message']
      end

      self.new opts
    end
  end
end
