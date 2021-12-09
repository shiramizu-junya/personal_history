puts "my_histories ..."

User.all.each_with_index do |user, i|
  user.create_my_history!(
    status: Faker::Number.between(from: 0, to: 1),
    title: "タイトル_#{ i + 1 }",
  )
end
