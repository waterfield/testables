class Task
  include Mongoid::Document
  scope :unstarted, where(status: "unstarted")

  field :status, :type => String
  field :contents, :type => Hash
  field :result, :type => Hash

  class << self
    def enqueue contents
      Task.create!(
        status: 'unstarted',
        contents: contents
      )
    end
  end
end
