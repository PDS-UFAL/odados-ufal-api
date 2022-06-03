class FormSends::FormSerializer < ActiveModel::Serializer
  attributes :id, :title, :sectors, :form_sends, :description, :created_at, :updated_at, :sections

  def sectors
      object.sector_ids&.map { |sector_id| SectorSerializer.new(Sector.find(sector_id)) }
  end

  def form_sends
      @form_sends = FormSend.where(form_id: object.id)
      @form_sends = @form_sends.sort { |a, b| (a.year <=> b.year) == 0 ? (a.start_date <=> b.start_date) : (a.year <=> b.year) }
      @form_sends.map { |form_send| FormSends::FormSendSerializer.new(form_send) }
  end

  def sections
      object.sections&.map { |section| FormSends::SectionSerializer.new(section) }
  end

  class FormSends::FormSendSerializer < ActiveModel::Serializer
      attributes :id, :subtitle, :year, :status, :start_date, :end_date
  end
  
  class FormSends::SectionSerializer < ActiveModel::Serializer
      attributes :id, :name, :questions
  
      def questions
          object.questions&.map { |question| FormSends::QuestionSerializer.new(question) }
      end

      class FormSends::QuestionSerializer < ActiveModel::Serializer
          attributes :id, :title, :type, :required, :max_char, :max_value, :min_value, :options, :responses

          def responses
              @responses = object.responses
              @responses = @responses.sort { |a, b| (FormSend.find(a.fsend).year <=> FormSend.find(b.fsend).year) == 0 ? (FormSend.find(a.fsend).start_date <=> FormSend.find(b.fsend).start_date) : (FormSend.find(a.fsend).year <=> FormSend.find(b.fsend).year) }
              @responses.map { |response| FormSends::ResponseSerializer.new(response) }
          end

          class FormSends::ResponseSerializer < ActiveModel::Serializer
              attributes :id, :answer, :fsend, :sector_id
          end
      end
  end
end
