class Tables::FormSerializer < ActiveModel::Serializer
    attributes :id, :title, :sectors, :form_sends, :description, :sections
	
    def sectors
        object.sector_ids&.map { |sector_id| SectorSerializer.new(Sector.find(sector_id)) }
    end

    def form_sends
        @form_sends = FormSend.where(form_id: object.id)
        @form_sends.map { |form_send| Tables::FormSendSerializer.new(form_send) }
    end

    def sections
        object.sections&.map { |section| Tables::SectionSerializer.new(section, sector: @instance_options[:sector]) }
    end

    class Tables::FormSendSerializer < ActiveModel::Serializer
        attributes :id, :subtitle, :year, :status
    end
    
    class Tables::SectionSerializer < ActiveModel::Serializer
        attributes :id, :name, :questions
    
        def questions
            object.questions&.map { |question| Tables::QuestionSerializer.new(question, sector: @instance_options[:sector]) }
        end

        class Tables::QuestionSerializer < ActiveModel::Serializer
            attributes :id, :title, :type, :required, :max_char, :max_value, :min_value, :options, :responses

            def responses
                @response_years = []
                @responses = []

                object.responses.each do |response|
                    if response.user.sector.id == @instance_options[:sector]
                        @form_send = FormSend.find(response.fsend)
                        @response_years.append(@form_send.year)
                        @responses.append({ "body": response, "year": @form_send.year })
                    end
                end
                
                @response_years = @response_years.uniq
                @response_years = @response_years.sort
                @responses = @responses.sort { |a, b| a[:body][:created_at] <=> b[:body][:created_at] }
                
                @size = @response_years.length()
                @filtred_responses = Array.new(@size)
                
                @responses.each do |response|
                    @index = @response_years.bsearch_index { |val| response[:year] <=> val }
                    @filtred_responses[@index] = {
                        "id": response[:body][:id],
                        "answer": response[:body][:answer],
                        "form_send_id": response[:body][:fsend],
                        "sector_id": User.find(response[:body][:user_id]).sector_id,
                        "year": response[:year]
                    }
                end

                @filtred_responses
            end
        end
    end
end