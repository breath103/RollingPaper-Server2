class SoundContent < ActiveRecord::Base
  include Paperclip::Glue 
  belongs_to :user
  belongs_to :paper
  has_attached_file :sound, 
  	:url => "http://#{ASSET_HOST}/:class/:attachment/:id/:style/:basename.:extension",
    :path => ":rails_root/public/:class/:attachment/:id/:style/:basename.:extension"
  attr_accessible :id, :user_id, :paper_id
  attr_accessible :x, :y, :width, :height, :rotation
  attr_accessible :sound
end
