# == Schema Information
#
# Table name: forms
#
#  id           :bigint           not null, primary key
#  end_date     :date
#  initial_date :date
#  sections     :jsonb
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class FormSerializer < ActiveModel::Serializer
  attributes :id, :title, :sections, :initial_date, :end_date, :created_at, :updated_at
end
