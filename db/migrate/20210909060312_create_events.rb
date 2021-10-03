class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.date :memory_date, null: false
      t.integer :category_id, null: false
      t.string :title, null: false
      t.string :memory_image
      t.text :episode, null: false
      t.integer :happiness, null: false
      t.references :personal_history, null: false, foreign_key: true

      t.timestamps
    end
  end
end
