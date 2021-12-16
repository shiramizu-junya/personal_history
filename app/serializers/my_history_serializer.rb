class MyHistorySerializer < ActiveModel::Serializer
  attributes :id, :status, :title
  # 関連モデルのオブジェクトも取得
  has_many :events
end
