class RenamePersonalHistoriesToMyHistories < ActiveRecord::Migration[6.0]
  def change
    rename_table :personal_histories, :my_histories
  end
end
