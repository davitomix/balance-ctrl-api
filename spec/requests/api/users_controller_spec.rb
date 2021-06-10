require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST /signup' do
    subject(:call) { post :create, params: params }

    context 'with valid params' do
      let(:params) do
        { user: { name: 'Mr Rodriguez', email: 'mrrodr@example.com', password: 'password',
                  password_confirmation: 'password' } }
      end

      it 'creates new user' do
        call

        new_user = User.find_by(email: 'mrrodr@example.com')

        data = JSON.parse(response.body)

        expect(response).to have_http_status(:created)
        expect(data['id']).to eq(new_user.id)
        expect(User.all.count).to eq(1)
        expect(new_user.password_digest).to_not be_blank
      end
    end

    context 'with invalid params' do
      let(:params) { { user: { email: '' } } }

      it 'handles validation errors' do
        call

        data = JSON.parse(response.body)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(User.all.count).to eq(0)
        expect(data['id']).to be_nil
      end
    end
  end
end
