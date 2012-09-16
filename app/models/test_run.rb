class TestRun
  include Mongoid::Document
  include Mongoid::Timestamps

  field :ran_at, type: DateTime
  field :passed, type: Boolean
  field :raw_output, type: String
  field :file_count, type: Fixnum
  field :files_done, type: Fixnum

  belongs_to :suite
  has_many :tasks
  embeds_many :test_results

  def finish_tests task
    self.files_done += task.contents[:files].size
    if examples = task.result['output']['examples'] rescue nil
      examples.each &method(:add_example)
    end
    finish_run if files_done == file_count
    save!
  end

  def add_example example
    test_results << TestResult.from_rspec(example)
  end

  def finish_run
    self.ran_at = Time.now
    self.passed = test_results.all? &:passed
  end
end
