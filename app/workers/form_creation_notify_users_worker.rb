class FormCreationNotifyUsersWorker
  include Sidekiq::Worker

  sidekiq_options retry: 3

  def perform sector_id, form_send_id
    @sector = Sector.find(sector_id)
    @form_send = FormSend.find(form_send_id)

    @sector.users.each { |user| user.send_form_notification(@form_send) }
  end
end
