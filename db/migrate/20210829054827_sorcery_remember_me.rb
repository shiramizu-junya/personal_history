class SorceryRememberMe < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :remember_me_token, :string, default: nil, after: :salt
    add_column :users, :remember_me_token_expires_at, :datetime, default: nil, after: :remember_me_token

    add_index :users, :remember_me_token
  end
end
