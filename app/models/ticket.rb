class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :paper
  attr_accessible :id, :user_id, :paper_id

  #uniq ticket for paper_id - user_id combination
  validates :paper_id, uniqueness: { scope: [:user_id] }
end
