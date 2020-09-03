FactoryBot.define do
  factory :balance do
    user_id { Faker::Number.number(digits: 12) }
    title { Faker::Lorem.word }
    total { Faker::Number.number(digits: 8) }
    category { Faker::Hipster.word }
  end
end