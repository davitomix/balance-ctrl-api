require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      let!(:user) { UserFactory.create }

      it 'returns a success response' do
        post :create, params: {
          user: {
            email: user.email,
            password: 'password'
          }
        }

        expect(response).to have_http_status(:ok)
      end

      it 'returns a success response' do
        post :create, params: {
          user: {
            email: user.email,
            password: 'password'
          }
        }

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq(
          {
            logged_in: true,
            user: {
              id: user.id,
              name: user.name,
              email: user.email
            }
          }.to_json
        )
      end
    end

    context 'with invalid params' do
      it 'has status unauthorized' do
        post :create, params: {
          user: {
            email: 'wrong@email.com',
            password: 'wrongpassword'
          }
        }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
