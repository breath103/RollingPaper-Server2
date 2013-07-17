class Invitation < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :paper
  attr_accessible :id, :sender_id, :paper_id, :friend_facebook_id, :receiver_name, :receiver_picture

  after_create :send_invitation
  
  # unique invitiaton for each paper_id - :friend_facebook_id combination
  validates :paper_id, uniqueness: { scope: [:friend_facebook_id] }
  
  def accept
    recipient = User.find_by_facebook_id (friend_facebook_id)
    if recipient 
      #if invitation accepted
      #send notification to user
      Ticket.create({user_id: recipient.id, paper_id: paper_id})
      Notification.create({
        sender: recipient,
        recipient: sender,
        notification_type: "invitation_accepted",
        source_id: paper_id,
        picture: recipient.picture,
        text: "#{recipient.username}님이 #{paper.title}에 참여했습니다."
      })
    end 
    false
  end
  
  def reject
    self.delete
  end
  
  def send_invitation
    recipient = User.find_by_facebook_id (friend_facebook_id)
    if recipient
      Notification.create({
        sender: sender,
        recipient: recipient,
        notification_type: "invitation_received",
        source_id: id,
        picture: sender.picture,
        text: "#{sender.username}님이 #{paper.title} 페이퍼로 초대하였습니다."
      }).send_apn
    end
    false
  end
end
