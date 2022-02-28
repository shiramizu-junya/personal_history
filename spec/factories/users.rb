FactoryBot.define do
  factory :user do
    uuid { SecureRandom.uuid }
    name { "user" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    birthday { nil }
    gender { nil }
    avatar { nil }
    password { "password" }
    password_confirmation { "password" }
  end
end
