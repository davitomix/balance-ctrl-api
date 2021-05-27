require 'faker'

class BalanceFactory
  class << self
    def create(params = {})
      Balance.create!(options(params))
    end

    def build(params = {})
      Balance.new(options(params))
    end

    private

    def options(params)
      {
        title: params.fetch(:title, Faker::Lorem.sentence(word_count: 5)),
        total: params.fetch(:email, Faker::Number.number(digits: 8)),
        category: params.fetch(:category, Faker::IndustrySegments.industry),
        user_id: params.fetch(:user_id) { user.id }
      }
    end

    def user
      UserFactory.create(password: 'password')
    end
  end
end
