# == Schema Information
#
# Table name: forms
#
#  status     :integer          default("open"), not null
#
class Form < ApplicationRecord
	has_many :form_sectors
	has_many :sectors, through: :form_sectors

  enum status: {
    closed: 0,
    open: 1
  }

	validates :status, presence: true
end
