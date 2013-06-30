class AddAdditionalInfoUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :picture, :string
    add_column :users, :birthday, :string
  end
end