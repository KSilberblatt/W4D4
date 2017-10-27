class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :user_name, null: false
      t.string :password_digest, null: false
      t.string :sessions_token, null: false

      t.timestamps
    end
    add_index :users, :user_name, unique: true
    add_index :users, :sessions_token, unique: true
  end
end
