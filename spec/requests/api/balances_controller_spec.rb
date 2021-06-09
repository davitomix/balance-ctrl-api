require 'rails_helper'

RSpec.describe BalancesController, type: :controller do
  describe 'GET /balances' do
    context 'when signed in user' do
      let(:user) { UserFactory.create }

      before { log_in_as(user) }

      it 'returns a success response' do
        balance_1 = BalanceFactory.create(user_id: user.id)
        balance_2 = BalanceFactory.create(user_id: user.id)

        get :index

        data = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(data['balances'].map { |o| o['id'] })
          .to match_array([balance_1.id, balance_2.id])
      end
    end

    context 'when not signed in' do
      it 'returns 401 code' do
        get :index

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /balance/:id' do
    let!(:user) { UserFactory.create }

    context 'when signed in user' do
      before { log_in_as(user) }

      it 'returns a success response' do
        balance_1 = BalanceFactory.create(user_id: user.id)

        get :show, params: {
          id: balance_1.id
        }

        data = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(data['balance']).to eq(JSON.parse(balance_1.to_json))
      end
    end

    context 'when not signed in' do
      it 'returns 401 code' do
        balance_1 = BalanceFactory.create(user_id: user.id)

        get :show, params: { 
          id: balance_1.id
        }

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when balance not exists' do
      before { log_in_as(user) }

      it 'returns 404' do
        get :show, params: { 
          id: 100
        }

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /balances' do
    let!(:user) { UserFactory.create }

    context 'when signed in user' do
      before { log_in_as(user) }

      it 'returns a success response' do
        post :create, params: { 
          balance: { 
            title: 'Industrial Shipment',
            total: 12_350,
            category: 'Technological Surgery',
            user_id: user.id
          }
        }

        data = JSON.parse(response.body)

        expect(response).to have_http_status(:created)
        expect(response.body).to include(user.id.to_json)
      end
    end

    context 'when not signed in' do
      it 'returns 401 code' do
        balance_1 = BalanceFactory.create(user_id: user.id)

        post :create, params: { 
          balance: { 
            title: 'Industrial Shipment',
            total: 12_350,
            category: 'Technological Surgery',
            user_id: user.id
          }
        }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
