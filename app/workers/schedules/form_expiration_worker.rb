class Schedules::FormExpirationWorker
  include Sidekiq::Worker

  def perform
    scope = Form.expired.status(:open).limit(100)

    while scope.exists?
      scope.each do |form|
        form.close && form.save
        sleep(0.05)
      end
    end
  end
end
