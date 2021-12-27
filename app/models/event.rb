class Event < ApplicationRecord
  belongs_to :my_history
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category

  validates :age, presence: true, numericality: { only_integer: true }, event_age: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :category_id, presence: true
  validates :episode, presence: :true, length: { maximum: 65_535 }
  validates :happiness, presence: :true, numericality: { only_integer: true, greater_than_or_equal_to: -100, less_than_or_equal_to: 100 }

  def self.group_events_by_age(events)
    group_events = {}

    events.each do |event|
      age = event.age

      if group_events.has_key?(age)
        group_events[age] << event
      else
        group_events[age] = [event]
      end
    end
    group_events
  end
end
