class WeightJob
  include Sidekiq::Job
  sidekiq_options queue: 'critical', tags: ['🌤']

  def perform(*args)
    p '~~WeightJob~~'
  end
end
