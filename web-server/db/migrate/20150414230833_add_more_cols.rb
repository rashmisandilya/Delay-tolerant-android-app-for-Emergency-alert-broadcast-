class AddMoreCols < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :international, :string
  end
end
