class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :my_history
  validates :body, presence: true, length: { maximum: 500 }
end
