class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :type, :required, :max_char, :max_value, :min_value, :options, :responses
  
  def responses
    object.responses&.map { |response| ResponseSerializer.new(response) }
  end
end