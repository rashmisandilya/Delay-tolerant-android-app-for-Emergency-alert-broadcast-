class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :degreeType
      t.string :department
      t.string :ip_address
      t.integer :role
      t.float :latitude
      t.float :longitude
      t.integer :alive

      t.timestamps null: false
    end
  end
end
