require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST /login' do
    subject(:call) { post :create, params: params }
    
    let!(:user) { UserFactory.create }

    context 'with valid credentials' do
      let(:params) { { user: { email: user.email, password: 'password' } } }

      it 'returns 200' do
        call

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

    context 'with invalid credentials' do
      let(:params) { { user: { email: 'wrong@email.com', password: 'wrongpassword' } } }

      it 'returns 401' do
        call

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with empty params' do
      let(:params) { {} }

      it 'returns 401' do
        call

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
