FactoryBot.define do
  factory :operation do
    title { Faker::Name.name }
    type { false }
    balance_id { nil }
  end
end