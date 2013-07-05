class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :paper
  attr_accessible :id, :user_id, :paper_id
end
