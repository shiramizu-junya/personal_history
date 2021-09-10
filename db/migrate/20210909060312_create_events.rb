class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.text :episode, null: false
      t.integer :happiness, null: false
      t.references :track, null: false, foreign_key: true
      t.integer :history_age_id, null: false

      t.timestamps
    end
  end
end
