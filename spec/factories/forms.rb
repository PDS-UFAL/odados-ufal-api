# == Schema Information
#
# Table name: forms
#
#  id          :bigint           not null, primary key
#  description :string
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :form do
    title { Faker::Name.name }
    start_date { Time.current.midnight }
    end_date { Time.current.end_of_day }

    trait :closed do
      status { :closed }
    end
  end
end
