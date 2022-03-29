class MyHistory < ApplicationRecord
  mount_base64_uploader :graph_image, GraphImageUploader
  belongs_to :user
  has_many :events, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :status, presence: true, inclusion: { in: %w[published unpublished], message: "を選択してください" }, allow_nil: true
  validates :title, presence: true, length: { maximum: 50 }, allow_nil: true
  validates :user_id, uniqueness: true

  before_create -> { self.uuid = SecureRandom.uuid }

  enum status: { published: 0, unpublished: 1 }

  scope :order_of_most_likes, -> {
    left_outer_joins(:likes).group("my_histories.id").select("my_histories.*, COUNT(likes.my_history_id)").order("COUNT(likes.my_history_id) DESC")
  }
end
