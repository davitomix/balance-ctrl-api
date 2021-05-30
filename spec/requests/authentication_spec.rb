require 'rails_helper'

RSpec.describe 'AuthenticationController', type: :request do
  let(:user) { UserFactory.create(password: 'password', password_confirmation: 'password') }
  let(:headers) { valid_headers.except('Authorization') }

  describe 'POST /auth/login' do
    context 'When request is valid' do
      it 'returns an authentication token' do
        post '/auth/login',
             headers: headers,
             params: {
               email: user.email,
               password: user.password
             }.to_json

        data = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(data['auth_token']).not_to be_nil
        expect(data['user_id']).to be_a(Numeric)
      end
    end

    context 'When request is invalid' do
      it 'returns a failure message' do
        post '/auth/login',
             headers: headers,
             params: {
               email: Faker::Internet.email,
               password: Faker::Internet.password
             }.to_json

        data = JSON.parse(response.body)

        expect(response).to have_http_status(401)
        expect(data['message']).to match(/Invalid credentials/)
        expect(data['auth_token']).to be_nil
        expect(data['user_id']).to be_nil
      end
    end
  end
end
