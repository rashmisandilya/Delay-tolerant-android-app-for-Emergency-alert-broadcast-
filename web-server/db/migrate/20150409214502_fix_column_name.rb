class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :ip_address, :reg_id
  end
end
