class Paper < ActiveRecord::Base
  include Paperclip::Glue 
  attr_accessible :creator_id, :title, :notice, :width, :height, :created_time, :id, :friend_facebook_id, :receive_time, :background  
  attr_accessible :state, :is_feedback_sended, :recipient_name

  has_attached_file :thumbnail, :styles => {:thumb => '120x120>', :large => '640x480>' }
  
  belongs_to :creator, class_name: User.to_s, foreign_key: :creator_id, autosave: true
  has_many :image_contents
  has_many :sound_contents
  has_many :tickets, dependent: :destroy
  has_many :invitations
  has_many :participants, source: :user, through: :tickets
  
  validates :creator, presence: true
  validates :title, presence: true, length: { maximum: 128 }
  validates :notice, length: { maximum: 512 }
  validates :width, presence: true
  validates :height, presence: true
  validates :friend_facebook_id, presence: true
  validates :receive_time, presence: true
  validates :background, presence: true
  validates :state, presence: true, inclusion: { in: ["editing", "sended" , "opened"] }
  validates :recipient_name, presence: true
  
  after_save :handle_receive_time_changed, :if => :receive_time_changed?
  after_save :handle_state_changed, :if => :state_changed?

  def contents
    {
      image: image_contents,
      sound: sound_contents
    }
  end
    
  def web_view_url 
    "http://#{ASSET_HOST}/papers/#{id}"
  end
  
  def handle_receive_time_changed
    print "handle_receive_time_changed"
    PaperSendNotificationWorker.perform_at( self.receive_time.utc, self.id )
    PaperDeadlineNotificationWorker.perform_at( (self.receive_time - 10.minutes).utc, self.id )
  end
  
  def handle_state_changed
    PaperOpenNotificationWorker.perform_async(self.id) if (state == "opened")      
  end
end
