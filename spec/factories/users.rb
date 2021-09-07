FactoryBot.define do
  factory :user do
    name { "tanaka_ken" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
