puts "users ..."

150.times do |n|
  User.create!(
    uuid: SecureRandom.uuid,
    name: "user_#{ n + 1 }",
    email: "sample_#{ n + 1 }@example.com",
    birthday: Faker::Date.between(from: "1923-04-01", to: "2007-04-01"),
    gender: Faker::Number.between(from: 0, to: 3),
    avatar: File.open("./app/assets/images/seeds/avatar_#{ rand(1..5) }.jpg"),
    password: "password",
    password_confirmation: "password",
  )
end
