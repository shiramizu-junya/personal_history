class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  has_one :my_history, dependent: :destroy
  has_many :events, through: :my_history

  validates :name, presence: true, length: { maximum: 10 }
  validates :email, uniqueness: { case_sensitive: true }, presence: true
  validates :birthday, presence: true, birth_day: true, on: :update
  validates :gender, inclusion: { in: %w[men women other no_answer], message: "を選択してください" }, on: :update
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  enum gender: { men: 0, women: 1, other: 2, no_answer: 3 }

  # 生年月日から年齢を計算する
  def calc_age
    (Time.zone.today.strftime("%Y%m%d").to_i - birthday.strftime("%Y%m%d").to_i) / 10_000
  end
end
