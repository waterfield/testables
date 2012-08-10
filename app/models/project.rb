class Project
  include Mongoid::Document
  field :name, type: String
  field :repository, type: String
end
