object @paper

child(:image_contents => :image) do
	attributes :user_id, :paper_id, :x, :y ,:width, :height, :rotation
	node(:image) { |i| i.image.url }
end
