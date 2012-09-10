class Project
  include Mongoid::Document

  field :name, type: String
  field :repository, type: String

  has_many :suites

  validates_presence_of :name, :repository
  validates_format_of :repository, with: /^(\w+)\/(\w+)$/, message: "should be in the form of 'owner/repository'"

  class << self
    def notify repository
      where(repository: repository).each &:test!
    end
  end

  def task
    { 'url' => "git@github.com:#{repository}.git" }
  end

  def test!
    suites.each &:test!
  end
end
