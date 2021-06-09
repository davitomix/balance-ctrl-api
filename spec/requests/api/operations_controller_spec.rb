require 'rails_helper'

RSpec.describe OperationsController, type: :controller do
  describe 'GET /operations' do
    context 'when signed in user' do
      let(:user) { UserFactory.create }

      before { log_in_as(user) }

      it 'returns a success response' do
        operation_1 = OperationFactory.create(user: user)
        operation_2 = OperationFactory.create(user: user)

        get :index

        data = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(data['operations'].map { |o| o['id'] })
          .to match_array([operation_1.id, operation_2.id])
      end
    end

    context 'when not signed in' do
      it 'returns 401 code' do
        get :index

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /operation/:id' do
    let!(:user) { UserFactory.create }

    context 'when signed in user' do
      before { log_in_as(user) }

      it 'returns a success response' do
        operation = OperationFactory.create(user: user)

        get :show, params: {
          id: operation.id
        }

        data = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(data).to eq(OperationSerializer.new.serialize(operation).as_json)
      end
    end

    context 'when not signed in' do
      it 'returns 401 code' do
        operation = OperationFactory.create(user: user)

        get :show, params: {
          id: operation.id
        }

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when operation not exists' do
      before { log_in_as(user) }

      it 'returns 404' do
        get :show, params: {
          id: 100
        }

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /operations' do
    let!(:user) { UserFactory.create }

    context 'when signed in user' do
      before { log_in_as(user) }

      it 'returns a success response' do
        balance = BalanceFactory.create(user_id: user.id)

        post :create, params: {
          operation: {
            title: 'Industrial Shipment',
            status: 1,
            balance_id: balance.id
          }
        }

        expect(response).to have_http_status(:created)
        expect(response.body).to include(balance.id.to_json)
      end
    end

    context 'when not signed in' do
      it 'returns 401 code' do
        balance = BalanceFactory.create(user_id: user.id)

        post :create, params: {
          operation: {
            title: 'Industrial Shipment',
            status: 1,
            balance_id: balance.id
          }
        }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT /operation/:id' do
    let!(:user) { UserFactory.create }

    context 'when signed in user' do
      before { log_in_as(user) }

      it 'returns a success response' do
        operation = OperationFactory.create(user: user)

        put :update, params: {
          id: operation.id,
          operation: {
            title: 'Industrial Shipment',
            status: 2
          }
        }

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when operation not exists' do
      before { log_in_as(user) }

      it 'returns 404' do
        put :update, params: {
          id: 100,
          operation: {
            title: 'Industrial Shipment',
            status: 2
          }
        }

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when not signed in' do
      it 'returns 401 code' do
        operation = OperationFactory.create(user: user)

        put :update, params: {
          id: operation.id,
          operation: {
            title: 'Industrial Shipment',
            status: 2
          }
        }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /operation/:id' do
    let!(:user) { UserFactory.create }

    context 'when signed in user' do
      before { log_in_as(user) }

      it 'returns a success response' do
        operation = OperationFactory.create(user: user)

        delete :destroy, params: {
          id: operation.id
        }

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when operation not exists' do
      before { log_in_as(user) }

      it 'returns 404' do
        delete :destroy, params: {
          id: 100
        }

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when not signed in' do
      it 'returns 401 code' do
        operation = OperationFactory.create(user: user)

        delete :destroy, params: {
          id: operation.id
        }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
