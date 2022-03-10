FactoryBot.define do
  factory :event do
    age { 10 }
    title { "タイトル" }
    episode { "エピソード" }
    happiness { 50 }
    association :my_history
  end
end
