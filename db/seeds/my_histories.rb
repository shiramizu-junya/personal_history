puts "my_histories ..."

User.all.each do |user|
  user.create_my_history!(
    status: Faker::Number.between(from: 0, to:1),
    title: Faker::Food.fruits,
  )
end
