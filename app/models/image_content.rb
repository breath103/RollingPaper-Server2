class ImageContent < ActiveRecord::Base
  include Paperclip::Glue 
  belongs_to :user
  belongs_to :paper
  has_attached_file :image,
    :styles => {:thumb => '120x120>', :large => '640x480>' },
    :default_style => :thumb,
    :url  => "http://rollingpaper-production.herokuapp.com/:class/:attachment/:id/:style/:basename.:extension",
    :path => ":rails_root/public/:class/:attachment/:id/:style/:basename.:extension"
  attr_accessible :id, :user_id, :paper_id
  attr_accessible :x, :y, :width, :height, :rotation
  attr_accessible :image 
  
  def center
    {
      x: x-width*0.5,
      y: y-height*0.5
    }
  end 
  
  def css(p)
    c = self.center
    "width:#{width/p.width * 100}%;height:#{height/p.height * 100}%;left:#{c[:x]/p.width * 100}%;top:#{c[:y]/p.height * 100}%;
			   -webkit-transform:rotate(#{rotation / (Math::PI * 2 ) * 360}deg);";
  end
end
