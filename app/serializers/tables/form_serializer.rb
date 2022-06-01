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
                @sectors = [] 

                object.responses.each do |response|
                    if @instance_options[:sector].nil? or response.sector_id == @instance_options[:sector]
                        @form_send = FormSend.find(response.fsend)
                        @sectors.append(response.sector_id)
                        @response_years.append(@form_send.year)
                        @responses.append({ "body": response, "year": @form_send.year, "sector_id": response.sector_id})
                    end
                end
                
                @response_years = @response_years.uniq
                @response_years = @response_years.sort

                @sectors =  @sectors.uniq
                @sectors =  @sectors.sort

                @responses = @responses.sort { |a, b| a[:body][:created_at] <=> b[:body][:created_at] }
                
                @x_size = @sectors.length()
                @y_size = @response_years.length()
                @filtred_responses = Array.new(@x_size) { Array.new(@y_size) }

                @responses.each do |response|
                    @x_index = @sectors.bsearch_index { |val| response[:sector_id] <=> val }
                    @y_index = @response_years.bsearch_index { |val| response[:year] <=> val }

                    @filtred_responses[@x_index][@y_index] = {
                        "id": response[:body][:id],
                        "answer": response[:body][:answer],
                        "form_send_id": response[:body][:fsend],
                        "year": response[:year],
                        "sector": SectorSerializer.new(Sector.find(response[:sector_id]))
                    }
                end

                @filtred_responses
            end
        end
    end
end