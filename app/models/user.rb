class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  has_many :tracks, dependent: :destroy
  has_many :events, through: :tracks

  validates :name, presence: true, length: { maximum: 10 }
  validates :email, uniqueness: { case_sensitive: true }, presence: true
  validates :age, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :gender, inclusion: { in: %w(men women), message: "を選択してください" }
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  enum gender: { men: 0, women: 1 }
end
