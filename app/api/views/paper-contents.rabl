object @paper

child(:image_contents => :image) do
	attributes :id, :user_id, :paper_id, :x, :y ,:width, :height, :rotation
	node(:image) { |i| i.image.url("original") }
end
child(:sound_contents => :sound) do
	attributes :id, :user_id, :paper_id, :x, :y ,:width, :height, :rotation
	node(:sound) { |i| i.sound.url }
end

