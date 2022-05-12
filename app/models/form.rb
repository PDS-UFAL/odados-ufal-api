# == Schema Information
#
# Table name: forms
#
#  id          :bigint           not null, primary key
#  description :string
#  sector_ids  :bigint           default([]), is an Array
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Form < ApplicationRecord
	has_many :sections, dependent: :destroy

	accepts_nested_attributes_for :sections, allow_destroy: true

	validates :title, presence: true

	scope :title, ->(title) { where("title ilike :title", title: "%#{title}%") }
end
