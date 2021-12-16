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
class Form < ApplicationRecord
	has_many :form_sectors
	has_many :sectors, through: :form_sectors

  enum status: {
    closed: 0,
    open: 1
  }

	validates :title, presence: true
	validates :status, presence: true
	validates :start_date, presence: true, date: {
			after_or_equal_to: Time.current.midnight,
			message: "deve ser pelo menos #{(Time.current.midnight).to_s}"
	}, on: :create
	validates :end_date, presence: true, date: { after: :start_date, message: "deve ser depois da data inicial" }
end
