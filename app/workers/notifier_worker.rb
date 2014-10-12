class NotifierWorker
  include Sidekiq::Worker

  sidekiq_options retry: 0

  def perform(notifier_id)
    @notifier = Notifier.find(notifier_id)
    @notifier.start!
  end
end
