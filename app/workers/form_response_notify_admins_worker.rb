class FormResponseNotifyAdminsWorker
  include Sidekiq::Worker

  sidekiq_options retry: 3

  def perform sector_id, form_send_id
    @sector = Sector.find(sector_id)
    @form_send = FormSend.find(form_send_id)

    User.role(:admin).each { |admin| admin.send_response_notification(@form_send, @sector) }
  end
end
