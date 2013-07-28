class Notification < ActiveRecord::Base

  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  attr_accessible :id, :sender, :recipient, :source_id, :sender_id, :recipient_id, :notification_type 
  attr_accessible :picture, :text
  validates_presence_of :recipient, :notification_type, :picture, :text
  validates :notification_type, presence: true, 
            inclusion: { in: ["invitation_accepted", "invitation_received" , 
                              "paper_deadline", "paper_deadline" ,
                              "paper_received", "paper_opened", 
                              "admin_notification"] }
  
  def send_apn 
    self.recipient.send_push_notification({
      badge: self.recipient.notifications.length,
      alert: text,
      custom_data: {
        id: id,
        type: notification_type,
        source_id: source_id
      }
    })
  end
end
