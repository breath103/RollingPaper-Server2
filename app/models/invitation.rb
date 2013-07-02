class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :paper
  attr_accessible :id, :user_id, :paper_id, :frined_facebook_id
end
