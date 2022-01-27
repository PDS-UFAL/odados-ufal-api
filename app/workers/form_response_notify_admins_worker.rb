class FormResponseNotifyAdminsWorker
  include Sidekiq::Worker

  sidekiq_options retry: 3

  def perform sector_id, form_id
    @sector = Sector.find(sector_id)
    @form = Form.find(form_id)

    User.role(:admin).each { |admin| admin.send_response_notification(@form, @sector) }
  end
end
