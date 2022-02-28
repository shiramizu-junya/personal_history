FactoryBot.define do
  factory :my_history do
    uuid { SecureRandom.uuid }
    status { :published }
    title { "タイトル" }
    graph_image { nil }
    association :user
  end
end
