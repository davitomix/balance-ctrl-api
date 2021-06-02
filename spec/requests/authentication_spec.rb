require 'rails_helper'
HMAC_SECRET = Rails.application.secret_key_base

RSpec.describe 'AuthenticationController', type: :request do
  let(:user) { UserFactory.create(password: 'password', password_confirmation: 'password') }
  let(:headers) { valid_headers.except('Authorization') }

  describe 'POST /login' do
    context 'When request is valid' do
      it 'returns an authentication token' do
        post '/login',
             headers: headers,
             params: {
               email: user.email,
               password: user.password
             }.to_json

        expect(response).to have_http_status(200)
      end

      it 'returns JWT token in authorization header' do
        post '/login',
             headers: headers,
             params: {
               email: user.email,
               password: user.password
             }.to_json

        expect(response.headers['Authorization']).to be_present
      end

      it 'returns valid JWT token' do
        post '/login',
             headers: headers,
             params: {
               email: user.email,
               password: user.password
             }.to_json

        token_from_request = response.headers['Authorization'].split.last
        decoded_token = JWT.decode(token_from_request, HMAC_SECRET)
        expect(decoded_token.first['user_id']).to be_present
      end
    end

    context 'When request is invalid' do
      it 'returns a failure message' do
        post '/login',
             headers: headers,
             params: {
               email: Faker::Internet.email,
               password: Faker::Internet.password
             }.to_json

        data = JSON.parse(response.body)

        expect(response).to have_http_status(401)
        expect(data['message']).to match(/Invalid credentials/)
      end
    end
  end
end
