# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  max_char   :integer
#  max_value  :integer
#  min_value  :integer
#  options    :string           default([]), is an Array
#  required   :boolean
#  title      :string
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  section_id :bigint           not null
#
# Indexes
#
#  index_questions_on_section_id  (section_id)
#
# Foreign Keys
#
#  fk_rails_...  (section_id => sections.id)
#
FactoryBot.define do
  factory :question do
    title { "MyString" }
    type { "" }
    required { false }
    max_char { 1 }
    max_value { 1 }
    min_value { 1 }
    options { "MyString" }
    section { nil }
  end
end
