class AddIndexOnCatsForeignKeys < ActiveRecord::Migration[5.1]
  def change
    remove_column :cats, :user_id, :string, null: false
    add_column :cats, :user_id, :integer, null: false
    add_index :cats, :user_id, unique: true
  end
end
