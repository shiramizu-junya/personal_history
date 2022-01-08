class Like < ApplicationRecord
  belongs_to :user
  belongs_to :my_history

  validates :user_id, uniqueness: { scope: :my_history_id }
end
