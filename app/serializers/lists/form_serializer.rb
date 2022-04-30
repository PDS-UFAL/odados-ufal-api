class Lists::FormSerializer < ActiveModel::Serializer
	attributes :id, :subtitle, :sectors, :start_date, :end_date, :status
	has_one :form

	def id
		$fsend = -1
		object.id
	end
end  