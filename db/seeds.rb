4.times do |i|
  user = User.find_or_create_by(email: "test#{i}@gmail.com")
  user.update(password: 'password') unless user.persisted?
  20.times { user.readings.create(level: rand(1..9), created_at: rand((DateTime.now - 3.months)...DateTime.now)) }
  3.times { user.readings.create(level: rand(1..9), created_at: DateTime.now) }
end
