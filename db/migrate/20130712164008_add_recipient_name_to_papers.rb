class AddRecipientNameToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :recipient_name, :string
  end
end
