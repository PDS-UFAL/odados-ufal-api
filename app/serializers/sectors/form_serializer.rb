class Sectors::FormSerializer < ActiveModel::Serializer
  attributes :id, :title, :start_date, :end_date, :status, :created_at, :updated_at, :sections

  def sections
    object.sections&.map { |section| Sectors::SectionSerializer.new(section, sector: @instance_options[:sector]) }
  end

	class Sectors::SectionSerializer < ActiveModel::Serializer
		attributes :id, :name, :questions
	
		def questions
			object.questions&.map { |question| Sectors::QuestionSerializer.new(question, sector: @instance_options[:sector]) }
		end

		class Sectors::QuestionSerializer < ActiveModel::Serializer
			attributes :id, :title, :type, :required, :max_char, :max_value, :min_value, :options, :responses
			
			def responses
				object.responses&.select { |response| response.user.sector_id == @instance_options[:sector].id }.map { |response| Sectors::ResponseSerializer.new(response) }
			end

			class Sectors::ResponseSerializer < ActiveModel::Serializer
				attributes :id, :answer
			end
		end
	end
end