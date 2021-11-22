class AddCategoryIdToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :category_id, :integer, after: :title, null: false
  end
end
