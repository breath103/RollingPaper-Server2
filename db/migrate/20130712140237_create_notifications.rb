class CreateNotifications < ActiveRecord::Migration
  def change
	  create_table :notifications do |t|
	    t.integer :sender_id
		  t.integer :recipient_id
      t.string  :notification_type
      t.string  :picture
      t.string  :text
      
	    t.timestamps
	  end
  end
end
