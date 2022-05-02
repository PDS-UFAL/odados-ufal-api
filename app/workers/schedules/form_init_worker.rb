class Schedules::FormInitWorker
  include Sidekiq::Worker

  def perform
    scope = FormSend.eligible.status(:not_started).limit(100)

    while scope.exists?
      scope.each do |form_send|
        form_send.start && form_send.save
        sleep(0.05)
      end
    end
  end
end
