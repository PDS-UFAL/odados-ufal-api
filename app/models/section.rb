# == Schema Information
#
# Table name: sections
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  form_id    :bigint           not null
#
# Indexes
#
#  index_sections_on_form_id  (form_id)
#
# Foreign Keys
#
#  fk_rails_...  (form_id => forms.id)
#
class Section < ApplicationRecord
  belongs_to :form
  has_many :questions

	accepts_nested_attributes_for :questions, allow_destroy: true

  validates_presence_of :name
end
