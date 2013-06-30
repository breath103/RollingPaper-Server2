class AddConnectionToUsers < ActiveRecord::Migration
  def change
    add_column :papers, :user_id, :integer
    
    add_index :papers, :user_id
  end
end
