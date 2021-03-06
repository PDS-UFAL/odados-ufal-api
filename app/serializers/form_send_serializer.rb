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
class FormSendSerializer < ActiveModel::Serializer
  attributes :id, :subtitle, :sectors, :year, :start_date, :end_date, :status
  has_one :form
end
