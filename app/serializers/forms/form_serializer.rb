class Forms::FormSerializer < ActiveModel::Serializer
    attributes :id, :title, :sectors, :description, :created_at, :updated_at, :sections
	
    def sectors
        object.sector_ids&.map { |sector_id| SectorSerializer.new(Sector.find(sector_id)) }
    end

    def sections
        object.sections&.map { |section| Forms::SectionSerializer.new(section) }
    end
    
    class Forms::SectionSerializer < ActiveModel::Serializer
        attributes :id, :name, :questions
    
        def questions
            object.questions&.map { |question| Forms::QuestionSerializer.new(question) }
        end

        class Forms::QuestionSerializer < ActiveModel::Serializer
            attributes :id, :title, :type, :required, :max_char, :max_value, :min_value, :options, :responses

            def responses
                object.responses.map { |response| Forms::ResponseSerializer.new(response) }
            end

            class Forms::ResponseSerializer < ActiveModel::Serializer
                attributes :id, :answer, :fsend
            end
        end
    end
end