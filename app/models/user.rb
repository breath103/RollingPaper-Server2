class User < ActiveRecord::Base
  has_many :created_papers, inverse_of: :creator, 
            class_name: Paper.to_s, foreign_key: :creator_id, autosave: true
  has_many :tickets
  has_many :papers , through: :tickets
  attr_accessible :username, :email, :picture, :name, :birthday, :facebook_id, :facebook_accesstoken, :apn_key
  
  def send_push_notification(options = {})
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
  
  def received_papers
    Paper.where(friend_facebook_id: facebook_id)
  end
  
  def received_invitations
    Invitation.find_by_friend_facebook_id(facebook_id)
  end
end
