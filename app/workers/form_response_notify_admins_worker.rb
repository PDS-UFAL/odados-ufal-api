class FormResponseNotifyAdminsWorker
  include Sidekiq::Worker

  sidekiq_options retry: true

  def perform(sector, form)
    User.role(:admin).each { |admin| admin.send_response_notification(form, sector) }
  end
end
