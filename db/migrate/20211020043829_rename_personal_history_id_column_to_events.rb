class RenamePersonalHistoryIdColumnToEvents < ActiveRecord::Migration[6.0]
  def change
    rename_column :events, :personal_history_id, :my_history_id
  end
end
