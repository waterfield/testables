class TestRun
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :ran_at, type: DateTime
  field :passed, type: Boolean
  field :project_name, type: String
  field :raw_output, type: String
  
  # attr_protected :ran_at, :passed, :project_name, :raw_output
  index :project_name
  index :ran_at
end
