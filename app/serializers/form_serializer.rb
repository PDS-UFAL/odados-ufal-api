class FormSerializer < ActiveModel::Serializer
  attributes :id, :title, :questions, :initial_date, :end_date, :created_at, :updated_at
end
