require 'rails_helper'

RSpec.describe 'OperationsController', type: :request do
  let(:user) do
    UserFactory.create(
      password: 'password',
      password_confirmation: 'password'
    )
  end
  let(:headers) { valid_headers }

  describe 'GET /operations' do
    it 'returns serialized operation' do
      operation_1 = OperationFactory.create(user: user)
      operation_2 = OperationFactory.create(user: user)

      get '/operations', headers: headers

      data = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(data['operations'].map { |o| o['id'] })
        .to match_array([operation_1.id, operation_2.id])
    end
  end

  describe 'GET /operation/:id' do
    it 'returns serialized operation' do
      operation = OperationFactory.create(user: user)

      get "/operations/#{operation.id}", headers: headers

      data = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(data).to eq(
        OperationSerializer.new.serialize(operation.reload).as_json
      )
    end

    it 'handles not_found error' do
      get '/operations/0', headers: headers

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:not_found)
      expect(data[:id]).to be_nil
    end
  end

  describe 'POST /operations' do
    it 'returns status code 201' do
      post '/operations',
           headers: headers,
           params: {
             operation: {
               title: 'Visit Narnia',
               status: 4,
               balance_id: 2
             }
           }.to_json

      operation = Operation.last

      expect(response).to have_http_status(:created)
      expect(operation.title).to eq('Visit Narnia')
      expect(operation.status).to eq(4)
      expect(operation.balance_id).to eq(2)
    end

    it 'handles validation error' do
      post '/operations',
           headers: headers,
           params: {
             operation: {
               title: nil,
               status: nil,
               balance_id: nil
             }
           }.to_json

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(Operation.all.count).to be_zero
      expect(data[:id]).to be_nil
    end
  end

  describe 'PUT /operations/:id' do
    it 'returns status code 201' do
      operation = OperationFactory.create(user: user)

      put "/operations/#{operation.id}",
          headers: headers,
          params: {
            operation: {
              title: 'New title',
              status: 4,
              balance_id: 2
            }
          }.to_json

      operation.reload

      expect(response).to have_http_status(:no_content)
      expect(operation.title).to eq('New title')
      expect(operation.status).to eq(4)
      expect(operation.balance_id).to eq(2)
    end

    it 'handles validation error' do
      operation = OperationFactory.create(
        user: user,
        title: 'A title',
        status: 0,
        balance_id: 2
      )

      put "/operations/#{operation.id}",
          headers: headers,
          params: {
            operation: {
              title: nil,
              status: nil,
              balance_id: nil
            }
          }.to_json

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(operation.title).to eq('A title')
      expect(operation.status).to eq(0)
      expect(operation.balance_id).to eq(2)
      expect(data[:id]).to be_nil
    end
  end

  describe 'DELETE /operation/:id' do
    it 'returns serialized operation' do
      operation = OperationFactory.create(user: user)

      delete "/operations/#{operation.id}", headers: headers

      expect(response).to have_http_status(:no_content)
    end

    it 'handles not_found error' do
      delete '/operations/0', headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end
end
