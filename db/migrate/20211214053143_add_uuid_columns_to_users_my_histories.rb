class AddUuidColumnsToUsersMyHistories < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :uuid, :string, after: :id, null: false
    add_column :my_histories, :uuid, :string, after: :id, null: false
    add_index :users, :uuid, unique: true
    add_index :my_histories, :uuid, unique: true
  end
end
