class HardJob
  include Sidekiq::Job

  def perform(*args)
    p '~Hard job working~', args
  end
end
