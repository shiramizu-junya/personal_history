class AddGraphImageToMyHistories < ActiveRecord::Migration[6.0]
  def change
    add_column :my_histories, :graph_image, :string, after: :title
  end
end
