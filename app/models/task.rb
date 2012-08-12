class Task
  include Mongoid::Document
  scope :unstarted, where(status: "unstarted")

  field :status, :type => String
  field :contents, :type => Hash
  field :result, :type => Hash

  class << self

    # Claim a task by finding one with no owner and
    # atomically setting the owner to the one provided.
    def claim owner
      while task = where(owner: nil).first
        where(_id: task.id, owner: nil).update_all(owner: owner)
        return task if task.reload.owner == owner
      end
    end

    def enqueue contents
      Task.create!(
        status: 'unstarted',
        contents: contents
      )
    end
  end
end
