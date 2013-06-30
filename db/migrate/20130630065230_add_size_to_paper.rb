class AddSizeToPaper < ActiveRecord::Migration
  def change
    add_column :papers, :width, :integer
    add_column :papers, :height, :integer
  end
end
