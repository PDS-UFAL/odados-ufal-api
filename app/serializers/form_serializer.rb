# == Schema Information
#
# Table name: forms
#
#  id           :bigint           not null, primary key
#  end_date     :date
#  initial_date :date
#  questions    :jsonb            not null
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class FormSerializer < ActiveModel::Serializer
  attributes :id, :title, :questions, :initial_date, :end_date, :created_at, :updated_at
end
