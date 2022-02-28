FactoryBot.define do
  factory :event do
    age { 30 }
    title { "タイトル" }
    episode { "エピソード" }
    happiness { 30 }
    association :my_history
  end
end
