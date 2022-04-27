class Lists::FormSerializer < ActiveModel::Serializer
	attributes :id, :subtitle, :sectors, :start_date, :end_date, :status
	has_one :form
end  