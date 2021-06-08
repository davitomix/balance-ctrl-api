require 'faker'

class UserFactory
  def self.create(params = {})
    User.create!(
      name: params.fetch(:email, Faker::Name.name),
      email: params.fetch(:email, Faker::Internet.email),
      admin: params.fetch(:admin, false),
      password: params[:password] || 'password',
      password_confirmation: params[:password_confirmation] || 'password'
    )
  end
end
