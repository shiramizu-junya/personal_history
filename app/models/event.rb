class Event < ApplicationRecord
  belongs_to :my_history

  validates :age, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :title, presence: true, length: { maximum: 50 }
  validates :episode, presence: :true, length: { maximum: 65_535 }
  validates :happiness, presence: :true, numericality: { only_integer: true, greater_than_or_equal_to: -100, less_than_or_equal_to: 100 }
end
