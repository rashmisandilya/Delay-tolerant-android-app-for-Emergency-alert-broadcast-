class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :heading
      t.string :content
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :messages, :users
  end
end
