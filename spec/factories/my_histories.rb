FactoryBot.define do
  factory :my_history do
    uuid { SecureRandom.uuid }
    status { rand(2) }
    sequence(:title) { |n| "タイトル_#{n}" }
    graph_image { nil }
    association :user
  end
end
