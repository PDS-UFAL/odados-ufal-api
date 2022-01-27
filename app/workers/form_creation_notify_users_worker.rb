class FormCreationNotifyUsersWorker
  include Sidekiq::Worker

  def perform(sector, form)
    sector.users.each { |user| user.send_form_notification(form) }
  end
end
