class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :my_history
  has_one :my_history_create_user, through: :my_history, source: :user

  validates :body, presence: true, length: { maximum: 500 }

  def newline_replace(comment_body)
    comment_body.gsub(/\n/, "%0a")
  end
end
