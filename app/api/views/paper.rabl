object @paper

attributes :id, :creator_id, :title, :notice, :width, :height
attributes :created_at, :updated_at, :friend_facebook_id, :receive_time, :background,:recipient_name

node(:thumbnail) { |p| p.thumbnail.url }

child :participants => :participants do
  attributes :id, :username, :picture, :facebook_id
end

child :invitations => :invitations do
  extends "invitation"
end