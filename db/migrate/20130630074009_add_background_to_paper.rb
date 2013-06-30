class AddBackgroundToPaper < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.float :x
      t.float :y
      t.float :width
      t.float :height
      t.float :rotation
      t.integer :paper_id
      t.integer :user_id
      t.string :image
    end
  end
end
