class AddFacebookToUser < ActiveRecord::Migration
  def change
    add_column :users, :facebook_id, :string
    add_column :users, :facebook_accesstoken, :string
  end
end
