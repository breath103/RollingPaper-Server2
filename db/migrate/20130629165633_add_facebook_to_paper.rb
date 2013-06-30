class AddFacebookToPaper < ActiveRecord::Migration
  def change
    add_column :papers, :friend_facebook_id, :string
  end
end
