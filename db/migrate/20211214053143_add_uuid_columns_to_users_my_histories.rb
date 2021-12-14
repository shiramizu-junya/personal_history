class AddUuidColumnsToUsersMyHistories < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :uuid, :string, after: :id, null: false, unique: true
    add_column :my_histories, :uuid, :string, after: :id, null: false, unique: true
  end
end
