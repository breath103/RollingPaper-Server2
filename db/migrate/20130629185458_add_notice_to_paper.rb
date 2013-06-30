class AddNoticeToPaper < ActiveRecord::Migration
  def change
    add_column :papers, :notice, :string
  end
end
