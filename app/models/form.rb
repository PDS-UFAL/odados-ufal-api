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
class Form < ApplicationRecord
	has_and_belongs_to_many :sectors
	validates_presence_of :title, :initial_date, :end_date
	validate :is_sections_an_array?

	private

	def is_sections_an_array?
		errors.add(:sections, "Invalid form") unless sections.is_a? Array
	end
end
