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


categories = ['Account 1', 'Account 2', 'Account 3', 'Bonus', 'Extras', 'Day', 'Week']

categories.length.times do |n|
    title  = Faker::IndustrySegments.sector
    total = Faker::Number.number(digits: 10)
    category = categories[n]
    User.first.balances.create(title: title,
                          total: total,
                          category: category)
end

users = User.all
users.each do |user|
  rand(5...10).times do |n|
    title  = Faker::IndustrySegments.sub_sector
    status = 1
    balance_id = rand(1...7)
    user.operations.create!(title: title,
                            status: status,
                            balance_id: balance_id)
  end
end