# == Schema Information
#
# Table name: forms
#
#  id           :bigint           not null, primary key
#  end_date     :date
#  initial_date :date
#  questions    :jsonb
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Form < ApplicationRecord
	validate :is_questions_an_array?, :is_questions_valid?

	private

	def is_questions_an_array?
		errors.add(:questions, "Invalid form") unless questions.is_a? Array
	end

	def is_questions_valid?
		errors.add(:questions.name) if questions.name.nil?
		errors.add(:questions.params) if questions.params.nil?
		errors.add(:questions.type) if questions.type.nil?
	end
	
end
