class AddTokenColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    remove_column :users, :alive
  end
end
