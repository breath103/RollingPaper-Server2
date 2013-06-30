class ImageContent < ActiveRecord::Base
  include Paperclip::Glue 
  belongs_to :user
  belongs_to :paper
  has_attached_file :image,
    :styles => {:thumb => '120x120>', :large => '640x480>' },
    :default_style => :thumb,
    :url => "http://0.0.0.0:3000/:class/:attachment/:id/:style/:basename.:extension",
    :path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension"
  attr_accessible :user_id, :paper_id
  attr_accessible :image 
  attr_accessible :x, :y, :width, :height, :rotation
end
