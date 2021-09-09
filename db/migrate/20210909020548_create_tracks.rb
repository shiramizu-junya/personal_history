class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks do |t|
      t.integer :published, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
