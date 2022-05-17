class FormSends::FormSerializer < ActiveModel::Serializer
  attributes :id, :title, :sectors, :form_sends, :description, :created_at, :updated_at, :sections

  def sectors
      object.sector_ids&.map { |sector_id| SectorSerializer.new(Sector.find(sector_id)) }
  end

  def form_sends
      @form_sends = FormSend.where(form_id: object.id)
      @form_sends.map { |form_send| FormSends::FormSendSerializer.new(form_send) }
  end

  def sections
      object.sections&.map { |section| FormSends::SectionSerializer.new(section) }
  end

  class FormSends::FormSendSerializer < ActiveModel::Serializer
      attributes :id, :subtitle, :year, :status
  end
  
  class FormSends::SectionSerializer < ActiveModel::Serializer
      attributes :id, :name, :questions
  
      def questions
          object.questions&.map { |question| FormSends::QuestionSerializer.new(question) }
      end

      class FormSends::QuestionSerializer < ActiveModel::Serializer
          attributes :id, :title, :type, :required, :max_char, :max_value, :min_value, :options, :responses

          def responses
              object.responses.map { |response| FormSends::ResponseSerializer.new(response) }
          end

          class FormSends::ResponseSerializer < ActiveModel::Serializer
              attributes :id, :answer, :fsend
          end
      end
  end
end