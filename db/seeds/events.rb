# require "./app/models/application_record"

puts "events..."

MyHistory.all.each do |my_history|
  # seedを実行する場合は、models/events.rbのevent_age: trueバリデーションをコメントアウトする
  age = my_history.user.calc_age

  my_history.events.create!(
    age: Faker::Number.between(from: 0, to: age),
    title: Faker::Food.dish,
    category_id: Faker::Number.between(from: 1, to: 10),
    episode: Faker::Food.description,
    happiness: Faker::Number.between(from: -100, to: 100),
  )
end
