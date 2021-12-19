class SectionSerializer < ActiveModel::Serializer
  attributes :id, :name, :questions

  def questions
    object.questions&.map { |question| QuestionSerializer.new(question) }
  end
end