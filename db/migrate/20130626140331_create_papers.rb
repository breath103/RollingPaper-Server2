class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers do |t|
      t.string :title

      t.timestamps
    end
  end
end
