class Invitation < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :paper
  attr_accessible :id, :sender_id, :paper_id, :friend_facebook_id, :receiver_name, :receiver_picture
  
  # unique invitiaton for each paper_id - :friend_facebook_id combination
  validates :paper_id, uniqueness: { scope: [:friend_facebook_id] }
  def accept
    Ticket.create({user_id: sender_id,paper_id: paper_id})
  end
end
