class Invitation < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :paper
  attr_accessible :id, :sender_id, :paper_id, :friend_facebook_id, :receiver_name, :receiver_picture

  after_create :send_invitation
  
  # unique invitiaton for each paper_id - :friend_facebook_id combination
  validates :paper_id, uniqueness: { scope: [:friend_facebook_id] }
  
  def accept
    Ticket.create({user_id: sender_id,paper_id: paper_id})

  end
  
  def reject
    self.delete
  end
  
    def send_invitation
      recipient = User.find_by_facebook_id (friend_facebook_id)
      if recipient
        n = Notification.create({
          sender: sender,
          recipient: recipient,
          notification_type: "receive_invitation",
          picture: sender.picture,
          text: "invitation from #{sender.username} to #{paper.title}"
        })
      end
    end
end
