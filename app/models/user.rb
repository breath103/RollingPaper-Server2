class User < ActiveRecord::Base
  has_many :created_papers, inverse_of: :creator, 
            class_name: Paper.to_s, foreign_key: :creator_id, autosave: true
  has_many :tickets
  has_many :papers , through: :tickets
  attr_accessible :username, :email, :picture, :name, :birthday, :facebook_id, :facebook_accesstoken
end
