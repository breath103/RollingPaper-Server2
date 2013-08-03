class CreateBackgrounds < ActiveRecord::Migration
  def change
    create_table :backgrounds do |t|
      t.attachment :image
      t.string :name
      t.timestamps
    end
  end
end
