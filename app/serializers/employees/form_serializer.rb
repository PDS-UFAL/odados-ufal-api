class Employees::FormSerializer < ActiveModel::Serializer
	attributes :id, :subtitle, :sectors, :year, :start_date, :end_date, :status
	has_one :form

  def sections
    object.sections&.map { |section| Employees::SectionSerializer.new(section, user: @instance_options[:user]) }
  end

	class Employees::SectionSerializer < ActiveModel::Serializer
		attributes :id, :name, :questions
	
		def questions
			object.questions&.map { |question| Employees::QuestionSerializer.new(question, user: @instance_options[:user]) }
		end

		class Employees::QuestionSerializer < ActiveModel::Serializer
			attributes :id, :title, :type, :required, :max_char, :max_value, :min_value, :options, :responses
			
			def responses
				object.responses&.select { |response| response.user_id == @instance_options[:user].id }.map { |response| Employees::ResponseSerializer.new(response) }
			end

			class Employees::ResponseSerializer < ActiveModel::Serializer
				attributes :id, :answer
			end
		end
	end
end