require 'runner'

class RspecRunner < Runner
  
  def run_test
    `#{prep_command}`
    # TODO: check if that failed...
    self.raw_output = `#{test_command}` if $?.success?
    self.passed = $?.success?
  end
  
  def prep_command
    "bundle install"
  end
  
  def test_command
    "bundle exec rspec"
  end
end
