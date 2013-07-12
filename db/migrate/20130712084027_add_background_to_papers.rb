class AddBackgroundToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :background, :string
  end
end
