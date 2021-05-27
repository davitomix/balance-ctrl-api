# rubocop:disable Layout/LineLength
require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:user) { User.new(password: 'password', password_confirmation: 'password') }
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_attributes) do
    { name: 'Mr Smith', email: 'mrsemith@example.com', password: 'password', password_confirmation: 'password' }
  end

  # User signup test suite
  describe 'POST /signup' do
    context 'when valid request' do
      before { post '/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end
      it 'returns failure message' do
        expect(json['message'])
          .to match(/Password can't be blank, Name can't be blank, Name is invalid, Email can't be blank, Email is invalid/)
      end
    end
  end
end
# rubocop:enable Layout/LineLength
