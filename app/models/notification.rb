class Notification < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
  
  attr_accessible :id, :sender, :recipient, :source_id, :sender_id, :recipient_id, :notification_type 
  attr_accessible :picture, :text
  validates_presence_of :sender, :recipient, :notification_type, :picture, :text
  
  after_create :after_create_notification
  
  private
    def after_create_notification
      self.recipient.send_push_notification({
        badge: 1,
        alert: text,
        custom_data: {
          type: "invitation",
          source_id: id
        }
      })
    end 
end
