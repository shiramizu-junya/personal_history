FactoryBot.define do
  factory :comment do
    body { "MyString" }
    user { nil }
    my_history { nil }
  end
end
