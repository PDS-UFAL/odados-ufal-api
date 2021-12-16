# == Schema Information
#
# Table name: forms
#
#  id         :bigint           not null, primary key
#  end_date   :date
#  start_date :date
#  status     :integer          default("open"), not null
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class FormSerializer < ActiveModel::Serializer
  attributes :id, :title, :start_date, :end_date, :status, :created_at, :updated_at
end
