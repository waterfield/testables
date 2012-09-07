class Project
  include Mongoid::Document

  has_many :tasks

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
    tasks.enqueue self, task
  end
end
