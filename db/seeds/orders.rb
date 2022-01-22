def rand_time(from, to=Time.now)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

def rand_in_range(from, to)
  rand * (to - from) + from
end

30.times do
  Order.create({
    state: "paid",
    amount_cents: rand(2000..5000),
    checkout_session_id: 'cs_test_a1Y8rmMSjqJeMUZNfU2drWfJdGlG7c75WBobJYBV7nvnxAqx7J6mf5lEP' + rand(0..9).to_s,
    user_id: 51,
    lesson_id: rand(1..400),
    created_at: rand_time(180.days.ago),
    updated_at: rand_time(180.days.ago)
  })
end

puts '30 random orders inserted'
