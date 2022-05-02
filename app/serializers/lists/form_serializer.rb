class Lists::FormSerializer < ActiveModel::Serializer
	attributes :id, :subtitle, :sectors, :start_date, :end_date, :status, :form

	def form
		@form_send_id = object.id
		FormSerializer.new(object.form, form_send_id: @form_send_id)
	end
end  