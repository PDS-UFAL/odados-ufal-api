class ResponseSerializer < ActiveModel::Serializer
  attributes :id, :answer
  has_one :user
end