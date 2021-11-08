class CreatePersonalHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :personal_histories do |t|
      t.integer :status, null: false, default: 1
      t.string :title
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
