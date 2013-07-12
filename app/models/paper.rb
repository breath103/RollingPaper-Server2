class Paper < ActiveRecord::Base
  attr_accessible :creator_id, :title, :notice, :width, :height, :created_time, :id, :friend_facebook_id, :receive_time, :background  
  attr_accessible :state, :is_feedback_sended, :recipient_name
  
  belongs_to :creator, class_name: User.to_s, foreign_key: :creator_id, autosave: true
  has_many :image_contents
  has_many :sound_contents
  has_many :tickets
  has_many :invitations
  has_many :participants, source: :user, through: :tickets
  
  validates :state, presence: true, inclusion: { in: ["editing", "wait_for_sended", "sended" , "opened"] }

  def contents
    {
      image: image_contents,
      sound: sound_contents
    }
  end
  def send_feedback_to_participants(feedback)
    if feedback.kind_of?(String)
      (users.each { |u| u.send_push_notification({badge: 0,alert: feedback}) }).length
    else
      (users.each { |u| u.send_push_notification(feedback) }).length
    end  
  end
end
