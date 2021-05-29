require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  let(:user) { User.new(password: 'password', password_confirmation: 'password') }
  let(:headers) { valid_headers.except('Authorization') }

  describe 'POST /signup' do
    context 'when valid request' do
      it 'creates a new user' do
        post '/signup',
             headers: headers,
             params: {
               user: {
                 name: 'Mr Smith',
                 email: 'mrsemith@example.com',
                 password: 'password',
                 password_confirmation: 'password'
               }
             }.to_json

        data = JSON.parse(response.body)

        expect(response).to have_http_status(201)
        expect(data['message']).to match(/Account created successfully/)
        expect(data['auth_token']).not_to be_nil
        expect(data['user_id']).to eq(34)
      end
    end

    context 'when invalid request' do
      it 'returns failure message' do
        post '/signup',
             headers: headers,
             params: {
               user: {
                 name: nil,
                 email: nil,
                 password: nil,
                 password_confirmation: nil
               }
             }.to_json

        data = JSON.parse(response.body)

        expect(response).to have_http_status(422)
        expect(data['message']).to match(/Validation failed/)
        expect(data['auth_token']).to be_nil
        expect(data['user_id']).to be_nil
      end
    end
  end
end
