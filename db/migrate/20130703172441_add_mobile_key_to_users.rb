class AddMobileKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :apn_key, :string
  end
end
