require 'faker'

class OperationFactory
  class << self
    def create(params = {})
      Operation.create!(options(params))
    end

    def build(params = {})
      Operation.new(options(params))
    end

    private

    def options(params)
      {
        title: params.fetch(:title, Faker::Lorem.sentence(word_count: 3)),
        status: params.fetch(:status, rand(0...9)),
        user: params[:user] || user ,
        balance_id: params.fetch(:balance_id, balance.id)
      }
    end

    def user
      @user ||= UserFactory.create(password: 'password')
    end

    def balance
      @balance ||= BalanceFactory.create(user_id: user.id)
    end
  end
end
