class Project
  include Mongoid::Document
  field :name, type: String
  field :repository, type: String

  class << self
    def notify repository
      where(repository: repository).each &:test!
    end
  end

  def task
    {
      'url' => "git@github.com:#{repository}.git",
      'type' => 'rspec'
    }
  end

  def test!
    Task.enqueue task
  end
end
