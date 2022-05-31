# == Schema Information
#
# Table name: form_sends
#
#  id         :bigint           not null, primary key
#  end_date   :datetime         not null
#  is_history :boolean
#  start_date :datetime         not null
#  status     :integer          default("open"), not null
#  subtitle   :string
#  year       :integer          default(2022), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  form_id    :bigint           not null
#
# Indexes
#
#  index_form_sends_on_form_id  (form_id)
#
# Foreign Keys
#
#  fk_rails_...  (form_id => forms.id)
#
class FormSend < ApplicationRecord
  include Form::Stateable

  belongs_to :form
	has_many :form_sectors, dependent: :destroy
	has_many :sectors, through: :form_sectors
	
  enum status: {
    closed: 0,
    open: 1,
		not_started: 2
  }

	validates :status, presence: true
	validates :start_date, presence: true, date: {
			after_or_equal_to: Time.current.midnight,
			message: "must be at least #{(Time.current.midnight).to_s}"
	}, on: :create
	validates :end_date, presence: true, date: { after: :start_date, message: 'must be after the start date' }

	scope :status, ->(status) { where(status: status) }
	scope :start_date, ->(start_date) { where("start_date >= ?", start_date) }
	scope :end_date, ->(end_date) { where("end_date <= ?", end_date) }
	scope :forms_by_sector, ->(sector_id) { joins(:form_sectors).where(form_sectors: { sector_id: sector_id }) }
	scope :expired, -> { where("end_date <= ?", Time.current) }
	scope :eligible, -> { where("start_date <= ?", Time.current) }
	scope :range_start_date, ->(range_start_date) { where("start_date >= ?", range_start_date) }
	scope :range_end_date, ->(range_end_date) { where("start_date <= ?", range_end_date) }
	scope :form_id, ->(form_id) { where(form_id: form_id) }

	before_create :set_status

	def can_respond? user
		user&.employee? && open? && on_schedule? && allowed_in_the_form?(user)
	end

	def allowed_in_the_form? user
		sectors.any? { |sector| sector.id == user.sector_id }
	end
	
	def on_schedule?
		(start_date..end_date).cover?(Time.current)
	end

	private

	def set_status
		self.status = 'not_started' if start_date > Time.current
	end
end
