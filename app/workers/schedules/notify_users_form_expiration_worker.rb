class Schedules::NotifyUsersFormExpirationWorker
  include Sidekiq::Worker

  sidekiq_options retry: true

  def perform
    FormSend.status(:open).each do |form_send|
      if ((form_send.end_date - Time.current) <= 1.day) && (form_send.form_sectors.any? { |fs| fs.waiting_response? || fs.waiting_resend? })
        form_send.form_sectors.each do |form_sector|
          form_sector.sector.users.each do |user|
            user.send_form_reminder(form_send)
          end
        end
      end
    end
  end
end
