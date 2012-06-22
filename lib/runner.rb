class Runner < Struct.new(:task)
  attr_accessor :passed, :raw_output
  
  def execute
    clone_repo
    # TODO: path push/pop
    pwd = Dir.pwd
    Dir.chdir path
    run_test
    Dir.chdir pwd
  end
  
  def result
    {passed: passed, raw_output: raw_output}
  end
  
  def clone_command path
    "git clone #{task[:url]} #{path}"
  end
  
  def path
    Rails.root.join 'tmp/checkout'
  end
  
  def run_test
    raise NotImplemented
  end
  
  class << self
    def runner_class type
      "#{type.classify}Runner".constantize
    end
    
    def build task
      runner_class(task[:type]).new task
    end
  end
  
private

  def clone_repo
    `rm -rf #{path}`
    `#{clone_command path}`
  end
  
end
