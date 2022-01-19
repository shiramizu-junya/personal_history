class Event < ApplicationRecord
  belongs_to :my_history

  validates :age, presence: true, numericality: { only_integer: true }, event_age: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :episode, presence: :true, length: { maximum: 65_535 }
  validates :happiness, presence: :true, numericality: { only_integer: true, greater_than_or_equal_to: -100, less_than_or_equal_to: 100 }

  def self.age_happiness_average(group_events)
    graph_events = {}
    group_events.each do |key, events|
      average_happiness = ((events.sum &:happiness) / (events.count)).floor
      event_hash = { key => average_happiness }
      graph_events.merge!(event_hash)
    end
    graph_events
  end
end
