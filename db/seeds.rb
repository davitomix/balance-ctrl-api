User.create(name:  "admin user",
  email: "example@railstutorial.org",
  password:              "foobar",
  password_confirmation: "foobar",
  admin: true)

4.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
password = "password"
User.create(name:  name,
    email: email,
    password:              password,
    password_confirmation: password)
end


users = User.all


5.times do |n|
  users.each do |user|
  title  = Faker::Lorem.word
  total = Faker::Number.number(digits: 10)
  category = Faker::Lorem.word
  user.balances.create(title: title,
                       total: total,
                       category: category)
  end
end

balances = Balance.all

2.times do |n|
  balances.each do |balance|
    title  = Faker::Name.name
    status = 1
    balance.operations.create(title: title,
                              status: status)
  end
end