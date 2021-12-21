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
  include Form::Stateable

	has_many :sections
	has_many :form_sectors
	has_many :sectors, through: :form_sectors

	accepts_nested_attributes_for :sections, allow_destroy: true

  enum status: {
    closed: 0,
    open: 1,
		not_started: 2
  }

	after_find { |form| start if not_started? && on_schedule? }

	validates :title, presence: true
	validates :status, presence: true
	validates :start_date, presence: true, date: {
			after_or_equal_to: Time.current.midnight,
			message: "must be at least #{(Time.current.midnight).to_s}"
	}, on: :create
	validates :end_date, presence: true, date: { after: :start_date, message: 'must be after the start date' }

	before_create :set_status

	def can_respond? user
		user&.employee? && open? && on_schedule? && allowed_in_the_form?(user)
	end

	private

	def on_schedule?
		(start_date..end_date).cover?(Time.current)
	end

	def allowed_in_the_form? user
		sectors.any? { |sector| sector.id == user.sector_id }
	end

	def set_status
		self.status = 'not_started' if start_date > Time.current
	end
end
