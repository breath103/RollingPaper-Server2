class AddStateToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :state, :string
  end
end
