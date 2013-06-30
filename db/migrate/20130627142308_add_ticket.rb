class AddTicket < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :user_id
      t.integer :paper_id
      t.timestamps
    end
  end
end
