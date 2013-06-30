class ImageContent < ActiveRecord::Base
  attr_accessible :x, :y, :width, :height, :rotation, :image, :user_id, :paper_id
  belongs_to :user
  belongs_to :paper
end
