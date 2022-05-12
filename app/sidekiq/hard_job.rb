class HardJob
  include Sidekiq::Job

  def perform(*args)
    p '~Hard job working~'
  end
end
