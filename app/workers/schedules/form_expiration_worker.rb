class Schedules::FormExpirationWorker
  include Sidekiq::Worker

  def perform
    scope = FormSend.expired.status(:open).limit(100)

    while scope.exists?
      scope.each do |form_send|
        form_send.close && form_send.save
        sleep(0.05)
      end
    end
  end
end
