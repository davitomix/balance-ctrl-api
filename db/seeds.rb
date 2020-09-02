10.times do |n|
  user_id = Faker::Number.number(digits: 10)
  title  = Faker::Lorem.word
  total = Faker::Number.number(digits: 10)
  category = Faker::Lorem.word
  Balance.create!(user_id: user_id,
                  title: title,
                  total: total,
                  category: category)
end

balances = Balance.all

5.times do |n|
  balances.each do |balance|
    title  = Faker::Name.name
    status = 1
    balance.operations.create!(title: title,
                               status: status)
  end
end