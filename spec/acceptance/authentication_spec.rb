require 'acceptance_helper'

resource 'Authentication' do
  let(:user) { create(:user) }
  explanation 'Authentication resources. '

  header 'Content-Type', 'application/json'

  post 'signup' do

    parameter :name, 'User name'
    parameter :email, 'User email'
    parameter :password, 'User password'
    parameter :password_confirmation, 'User password confirmation'

    context '201' do
      example_request 'Creating new user - Sign Up' do
        explanation 'Registers a new user in the database and generates token'
        do_request(name: 'Example', email: 'example-x@example.com', password: 'foobar', password_confirmation: 'foobar')
        expect(status).to eq(201)
      end
    end
  end

  post 'auth/login' do

    parameter :email, 'User email'
    parameter :password, 'User password'

    context '200' do
      example_request 'Generating new token - Log In' do
        explanation 'Logs in as a registered user and generates token.'
        do_request(email: user.email, password: user.password)
        expect(status).to eq(200)
      end
    end
  end
end