class CreateMobileKeys < ActiveRecord::Migration
  def change
    create_table :mobile_keys do |t|
      t.references :user
      t.string :type
      t.string :key

      t.timestamps
    end
  end
end
