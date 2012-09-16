class TestRun
  include Mongoid::Document
  include Mongoid::Timestamps

  field :ran_at, type: DateTime
  field :passed, type: Boolean
  field :raw_output, type: String

  belongs_to :suite
end
