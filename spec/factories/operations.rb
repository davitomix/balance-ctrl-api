FactoryBot.define do
  factory :operation do
    title { Faker::Name.name }
    status { 1 }
    balance_id { nil }
  end
end