# == Schema Information
#
# Table name: responses
#
#  id          :bigint           not null, primary key
#  answer      :string
#  fsend       :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint           not null
#  sector_id   :bigint
#  user_id     :bigint           not null
#
# Indexes
#
#  index_responses_on_question_id  (question_id)
#  index_responses_on_sector_id    (sector_id)
#  index_responses_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (sector_id => sectors.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :response do
    answer { "MyString" }
    question { nil }
    user { nil }
  end
end
