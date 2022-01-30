class Lists::FormSerializer < ActiveModel::Serializer
	attributes :id, :title, :status, :start_date, :end_date, :created_at, :updated_at
end  