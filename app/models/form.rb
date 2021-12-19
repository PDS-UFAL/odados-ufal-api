# == Schema Information
#
# Table name: forms
#
#  id         :bigint           not null, primary key
#  end_date   :datetime         not null
#  start_date :datetime         not null
#  status     :integer          default("open"), not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Form < ApplicationRecord
	has_many :sections
	has_many :form_sectors
	has_many :sectors, through: :form_sectors

	accepts_nested_attributes_for :sections, allow_destroy: true

  enum status: {
    closed: 0,
    open: 1
  }

	validates :title, presence: true
	validates :status, presence: true
	validates :start_date, presence: true, date: {
			after_or_equal_to: Time.current.midnight,
			message: "must be at least #{(Time.current.midnight).to_s}"
	}, on: :create
	validates :end_date, presence: true, date: { after: :start_date, message: 'must be after the start date' }
end
