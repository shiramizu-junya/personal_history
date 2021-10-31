class MyHistory < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy

  validates :status, presence: true, inclusion: { in: %w[public private], message: "を選択してください" }, on: :update
  validates :title, presence: true, length: { maximum: 50 }

  enum status: { published: 0, unpublished: 1 }
end
