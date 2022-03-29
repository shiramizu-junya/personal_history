class MyHistorySerializer < ActiveModel::Serializer
  attributes :id, :status, :title, :graph_events
  # 関連モデルのオブジェクトも取得
  has_many :events

  def graph_events
    group_events = object.events.order(age: :asc).group_by(&:age)
    Event.age_happiness_average(group_events)
  end
end
