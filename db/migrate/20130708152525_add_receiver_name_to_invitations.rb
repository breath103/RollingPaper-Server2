class AddReceiverNameToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :receiver_name, :string
    add_column :invitations, :receiver_picture, :string
  end
end
