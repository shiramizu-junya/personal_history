FactoryBot.define do
  factory :user do
    uuid { SecureRandom.uuid }
    sequence(:name) { |n| "ユーザー_#{n}" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    birthday { Date.current.ago(20.years).strftime("%Y-%m-%d") }
    gender { rand(4) }
    avatar { nil }
    password { "password" }
    password_confirmation { "password" }
  end
end
