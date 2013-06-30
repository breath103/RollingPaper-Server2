class FixColumnName < ActiveRecord::Migration
  def change 
    rename_column :papers, :user_id, :creator_id
  end
end
