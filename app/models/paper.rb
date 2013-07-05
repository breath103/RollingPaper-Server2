class Paper < ActiveRecord::Base
  belongs_to :creator, class_name: User.to_s, foreign_key: :creator_id, autosave: true
  has_many :image_contents
  has_many :sound_contents
  has_many :tickets
  has_many :users , through: :tickets
  attr_accessible :creator_id, :title, :notice, :width, :height, :created_time, :id, :friend_facebook_id, :receive_time, :background
        
  def contents
    {
      image: self.image_contents,
      sound: self.sound_contents
    }
  end
  
  def send_feedback_to_participants(feedback)
    (users.each { |u| u.send_push_notification({badge: 0,alert: feedback}) }).length
  end
end
