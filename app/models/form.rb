# == Schema Information
#
# Table name: forms
#
#  status     :integer          default("open"), not null
#
class Form < ApplicationRecord
	has_and_belongs_to_many :sectors
	validates_presence_of :title, :initial_date, :end_date
	validate :is_sections_an_array?

  enum status: {
    closed: 0,
    open: 1
  }

	validates :status, presence: true
end
