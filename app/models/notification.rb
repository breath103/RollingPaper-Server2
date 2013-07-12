require "awesome_print"
class Notification < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
  attr_accessible :id, :sender_id, :recipient_id, :notification_type, 
                  :picture, :text
end
