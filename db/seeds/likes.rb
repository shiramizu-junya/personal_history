puts "likes ..."

users = User.all
my_histories = MyHistory.all

150.times do
  user = users.sample
  my_history = my_histories.sample
  user.like(my_history)
end
