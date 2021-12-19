# == Schema Information
#
# Table name: forms
#
#  id         :bigint           not null, primary key
#  end_date   :datetime         not null
#  start_date :datetime         not null
#  status     :integer          default("open"), not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class FormSerializer < ActiveModel::Serializer
  attributes :id, :title, :start_date, :end_date, :status, :created_at, :updated_at, :sections

  def sections
    object.sections&.map { |section| SectionSerializer.new(section) }
  end

  class SectionSerializer < ActiveModel::Serializer
    attributes :id, :name, :questions

    def questions
      object.questions&.map { |question| QuestionSerializer.new(question) }
    end

    class QuestionSerializer < ActiveModel::Serializer
      attributes :id, :title, :type, :required, :max_char, :max_value, :min_value, :options, :responses
      
      def responses
        object.responses&.map { |response| ResponseSerializer.new(response) }
      end

      class ResponseSerializer < ActiveModel::Serializer
        attributes :id, :answer
        has_one :user
      end
    end
  end
end
