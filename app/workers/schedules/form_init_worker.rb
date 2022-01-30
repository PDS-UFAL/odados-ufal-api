class Schedules::FormInitWorker
  include Sidekiq::Worker

  def perform
    scope = Form.eligible.status(:not_started).limit(100)

    while scope.exists?
      scope.each do |form|
        form.start && form.save
        sleep(0.05)
      end
    end
  end
end
