class Forms::FormSerializer < ActiveModel::Serializer
    attributes :id, :title, :sectors, :form_sends, :description, :created_at, :updated_at, :sections
	
    def sectors
        object.sector_ids&.map { |sector_id| SectorSerializer.new(Sector.find(sector_id)) }
    end

    def form_sends
        @form_sends = FormSend.where(form_id: object.id)
        @form_sends.map { |form_send| Forms::FormSendSerializer.new(form_send) }
    end

    def sections
        object.sections&.map { |section| Forms::SectionSerializer.new(section) }
    end

    class Forms::FormSendSerializer < ActiveModel::Serializer
        attributes :id, :subtitle, :year, :status
    end
    
    class Forms::SectionSerializer < ActiveModel::Serializer
        attributes :id, :name, :questions
    
        def questions
            object.questions&.map { |question| Forms::QuestionSerializer.new(question) }
        end

        class Forms::QuestionSerializer < ActiveModel::Serializer
            attributes :id, :title, :type, :required, :max_char, :max_value, :min_value, :options
        end
    end
end