class Schedules::NotifyUsersFormExpirationWorker
  include Sidekiq::Worker

  sidekiq_options retry: true

  def perform
    Form.status(:open).each do |form|
      if ((Time.current - form.end_date) <= 1.day) && (form.form_sectors.any? { |fs| fs.waiting_response? || fs.waiting_resend? })
        form.form_sectors.each do |form_sector|
          form_sector.sector.users.each do |user|
            user.send_form_reminder(form)
          end
        end
      end
    end
  end
end
