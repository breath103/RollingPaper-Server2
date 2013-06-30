class CreateImageContents < ActiveRecord::Migration
  def change
    create_table :image_contents do |t|
      t.float :x
      t.float :y
      t.float :width
      t.float :height
      t.float :rotation
      t.integer :paper_id
      t.integer :user_id
    end
  end
end
