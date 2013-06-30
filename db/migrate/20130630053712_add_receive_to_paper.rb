class AddReceiveToPaper < ActiveRecord::Migration
  def change
    add_column :papers, :receive_time, :datetime
  end
end
