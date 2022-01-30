class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader
  cattr_accessor :current_user

  has_one :my_history, dependent: :destroy
  has_many :events, through: :my_history
  has_many :likes, dependent: :destroy
  has_many :like_my_histories, through: :likes, source: :my_history
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { maximum: 10 }
  validates :email, uniqueness: { case_sensitive: true }, presence: true
  validates :birthday, presence: true, birth_day: true, on: :update
  validates :gender, inclusion: { in: %w[men women other no_answer], message: "を選択してください" }, on: :update
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  # before_createコールバックは、オブジェクトがDBに新規保存(saveメソッド：INSERT文)される直前で実行される
  before_create -> { self.uuid = SecureRandom.uuid }

  enum gender: { men: 0, women: 1, other: 2, no_answer: 3 }

  # ログイン済みユーザーが作成したobjectか判定
  def own?(object)
    id == object.user_id
  end

  # いいね追加
  def like(my_history)
    like_my_histories << my_history
  end

  # いいね削除
  def unlike(my_history)
    like_my_histories.destroy(my_history)
  end

  # いいね済み判定
  def like?(my_history)
    like_my_histories.include?(my_history)
  end
end
