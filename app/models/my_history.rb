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
end
