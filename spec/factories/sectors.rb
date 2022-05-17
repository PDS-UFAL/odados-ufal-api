# == Schema Information
#
# Table name: sectors
#
#  id           :bigint           not null, primary key
#  abbreviation :string
#  email        :string           not null
#  name         :string           not null
#  responsible  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :sector do
    name { Faker::Name.name }
    responsible { Faker::Name.name }
    email { Faker::Internet.unique.email }
  end
end
