class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_by, :created_at, :updated_at

  #model associations
  has_many :items
end
