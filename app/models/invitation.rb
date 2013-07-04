class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :paper
  attr_accessible :id, :user_id, :paper_id, :frined_facebook_id
  
  def accept
    user = User.find_by_facebook_id(frined_facebook_id) 
    if user 
      t = Ticket.create({user_id: user.id, paper_id: paper_id})
      t
    else 
      
    end
  end

  def decline


  end
end
