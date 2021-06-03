require 'rails_helper'

RSpec.describe 'BalancesController', type: :request do
  let(:headers) { invalid_headers }

  describe 'GET /balances' do
    let(:user) do
      UserFactory.create(
        password: 'password',
        password_confirmation: 'password'
      )
    end

    it 'return balances' do
      balance_1 = BalanceFactory.create(user_id: user.id)
      balance_2 = BalanceFactory.create(user_id: user.id)

      get '/balances', headers: headers

      data = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(data['balances'].map { |o| o['id'] })
        .to match_array([balance_1.id, balance_2.id])
    end
  end

  describe 'GET /balance/:id' do
    let(:user) do
      UserFactory.create(
        password: 'password',
        password_confirmation: 'password'
      )
    end

    it 'return balance' do
      balance = BalanceFactory.create(user_id: user.id)

      get "/balances/#{balance.id}", headers: headers

      data = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(data['balance']).to eq(balance.serializable_hash.as_json)
    end

    it 'handles not_found error' do
      get '/balances/0', headers: headers

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:not_found)
      expect(data[:id]).to be_nil
    end
  end

  describe 'POST /balances' do
    let(:user) do
      UserFactory.create(
        password: 'password',
        password_confirmation: 'password',
      )
    end

    it 'returns status code 201' do
      post '/balances',
           headers: headers,
           params: {
             balance: {
               category: 'Robotics Manufacturer',
               total: 434_345,
               title: 'IoT Technology',
               user_id: user.id
             }
           }.to_json

      balance = Balance.last

      expect(response).to have_http_status(:created)
      expect(balance.category).to eq('Robotics Manufacturer')
      expect(balance.total).to eq(434_345)
      expect(balance.title).to eq('IoT Technology')
      expect(balance.user_id).to eq(user.id)
    end

    it 'handles validation error' do
      post '/balances',
           headers: headers,
           params: {
             balance: {
               category: nil,
               total: nil,
               title: nil,
               user_id: nil
             }
           }.to_json

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(Balance.all.count).to be_zero
      expect(data[:id]).to be_nil
    end
  end

  describe 'PUT /balances/:id' do
    let(:user) do
      UserFactory.create(
        password: 'password',
        password_confirmation: 'password',
        admin: true
      )
    end

    it 'returns status code 201' do
      balance = BalanceFactory.create(user_id: user.id)

      put "/balances/#{balance.id}",
          headers: headers,
          params: {
            balance: {
              category: 'Robotics Manufacturer',
              total: 434_345,
              title: 'IoT Technology',
              user_id: user.id
            }
          }.to_json

      balance.reload

      expect(response).to have_http_status(:no_content)
      expect(balance.category).to eq('Robotics Manufacturer')
      expect(balance.total).to eq(434_345)
      expect(balance.title).to eq('IoT Technology')
      expect(balance.user_id).to eq(user.id)
    end

    it 'handles validation error' do
      balance = BalanceFactory.create(
        category: 'Robotics Manufacturer',
        total: 434_345,
        title: 'IoT Technology',
        user_id: user.id
      )

      put "/balances/#{balance.id}",
          headers: headers,
          params: {
            balance: {
              category: nil,
              total: nil,
              title: nil,
              user_id: nil
            }
          }.to_json

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(data[:id]).to be_nil
    end
  end

  describe 'DELETE /balance/:id' do
    let(:user) do
      UserFactory.create(
        password: 'password',
        password_confirmation: 'password',
        admin: true
      )
    end

    it 'delete balance' do
      balance = BalanceFactory.create(user_id: user.id)

      delete "/balances/#{balance.id}", headers: headers

      expect(response).to have_http_status(:no_content)
    end

    it 'handles not_found error' do
      delete '/balances/0', headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end
end
