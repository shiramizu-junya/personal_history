class MyHistory < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy

  validates :status, presence: true, inclusion: { in: %w[published unpublished], message: "を選択してください" }, allow_nil: true
  validates :title, presence: true, length: { maximum: 50 }, allow_nil: true
  validates :user_id, uniqueness: true

  before_create -> { self.uuid = SecureRandom.uuid }

  enum status: { published: 0, unpublished: 1 }
end
