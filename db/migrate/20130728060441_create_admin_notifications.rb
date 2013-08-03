class CreateAdminNotifications < ActiveRecord::Migration
  def change
	  create_table :admin_notifications do |t|
      t.string  :picture
      t.string  :text
      t.timestamps
	  end
  end
end
