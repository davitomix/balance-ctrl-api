require 'rails_helper'

RSpec.describe BalancesController, type: :controller do
  describe 'GET #index' do
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
      it 'returns 404' do
        get :index

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
