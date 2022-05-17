# == Schema Information
#
# Table name: form_sends
#
#  id         :bigint           not null, primary key
#  end_date   :datetime         not null
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
FactoryBot.define do
  factory :form_send do
    subtitle { "MyString" }
    start_date { "2022-04-25 16:11:19" }
    end_date { "2022-04-25 16:11:19" }
    form { nil }
  end
end
