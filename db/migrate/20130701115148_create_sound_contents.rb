class CreateSoundContents < ActiveRecord::Migration
  def change
    create_table :sound_contents do |t|
	  t.float :x
	  t.float :y
	  t.float :width
	  t.float :height
	  t.float :rotation
	  t.integer :paper_id
	  t.integer :user_id
	  t.attachment :sound
 	end
  end
end
