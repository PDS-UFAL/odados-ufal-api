class FormCreationNotifyUsersWorker
  include Sidekiq::Worker

  sidekiq_options retry: 3

  def perform sector_id, form_id
    @sector = Sector.find(sector_id)
    @form = Form.find(form_id)

    @sector.users.each { |user| user.send_form_notification(@form) }
  end
end
