class User < ActiveRecord::Base
  has_many :created_papers, inverse_of: :creator, 
            class_name: Paper.to_s, foreign_key: :creator_id, autosave: true
  has_many :tickets, dependent: :destroy
  has_many :papers, through: :tickets
  has_many :invitations, foreign_key: :sender_id, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id
  attr_accessible :username, :email, :picture, :name, :birthday, :facebook_id, :facebook_accesstoken, :apn_key

  after_create :user_created  
  
  def send_push_notification(options = {})
    print "send#{apn_key}"
    if apn_key
      push_notification = Houston::Notification.new(device: apn_key)
      push_notification.badge = options[:badge] if options[:badge]
      push_notification.alert = options[:alert] if options[:alert]
      push_notification.custom_data = options[:custom_data] if options[:custom_data]
      APN.push(push_notification)
    else 
      return false
    end
  end 
  
  def received_invitations
    Invitation.where(friend_facebook_id: facebook_id)
  end
  
  def received_papers
    Paper.where(friend_facebook_id: facebook_id)
  end
  
  def sended_papers
    papers.where("state = 'opened' OR state = 'sended'")
  end
  
  private
    def user_created
      # handle invitation that not sended yet
      self.received_invitations.each {|i| i.send_invitation }
    end
end
