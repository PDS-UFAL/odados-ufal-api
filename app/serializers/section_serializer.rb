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
class SectionSerializer < ActiveModel::Serializer
  attributes :id, :name, :questions

  def questions
    object.questions&.map { |question| QuestionSerializer.new(question, form_send_id: @instance_options[:form_send_id]) }
  end
end
