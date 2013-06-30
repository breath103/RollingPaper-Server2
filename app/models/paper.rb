class Paper < ActiveRecord::Base
  belongs_to :creator, class_name: User.to_s, foreign_key: :creator_id, autosave: true
  has_many :image_contents
  has_many :tickets
  has_many :users , through: :tickets
  attr_accessible :creator_id, :title, :notice, :width, :height, :created_time, :id, :friend_facebook_id, :receive_time, :background
        
  def contents
    {
      image: self.image_contents,
      sound: []
    }
  end
end
