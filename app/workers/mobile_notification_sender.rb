class MobileNotificationSender
  include Sidekiq::Worker
  def perform(notification_id)
    notification = Notification.find(notification_id)
    notification.send_apn
  end
end
