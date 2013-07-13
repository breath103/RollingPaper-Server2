require "awesome_print"
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
  
  private 
    def send_invitation
      user = User.find_by_facebook_id (friend_facebook_id)
      ap user
      if user
        user.send_push_notification({
          badge: 1,
          alert: "invitation from #{sender.username} to #{paper.title}",
          custom_data: {
            type: "invitation",
            invitation_id: self.id
          }
        })
      end 
    end
end
