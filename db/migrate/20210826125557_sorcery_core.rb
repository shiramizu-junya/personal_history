class SorceryCore < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name,             null: false
      t.string :email,            null: false
      t.integer :age
      t.integer :gender
      t.string :avatar
      t.string :crypted_password
      t.string :salt

      t.timestamps                null: false
    end

    add_index :users, :email, unique: true
  end
end
