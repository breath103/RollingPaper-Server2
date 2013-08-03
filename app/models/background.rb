class Background < ActiveRecord::Base
  has_attached_file :image, :styles => {:thumb => '120x120>', :large => '640x480>' }
  attr_accessible :image,:name
end
