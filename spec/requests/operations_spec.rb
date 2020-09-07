# rubocop:disable Layout/LineLength
require 'rails_helper'

RSpec.describe 'Operations API requested by LOGGED IN USER' do
  let(:user) { create(:user, password_confirmation: 'foobar') }
  # Initialize the test data
  let!(:balance) { create(:balance, user_id: user.id) }
  let!(:operations) { create_list(:operation, 20, balance_id: balance.id, status: 1, user_id: user.id) }
  let(:balance_id) { balance.id }
  let(:id) { operations.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /users/:user_id/operations
  describe 'GET /users/:user_id/operations' do
    before { get "/users/#{user.id}/operations", params: {}, headers: headers }

    context 'when operations exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all user operations' do
        expect(json.size).to eq(20)
      end
    end
  end

  # Test suite for GET /users/:user_id/operations/:id
  describe 'GET /users/:user_id/operations/:id' do
    before { get "/users/#{user.id}/operations/#{id}", params: {}, headers: headers }

    context 'when user operation exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the operation' do
        expect(json['id']).to eq(id)
      end
    end
  end

  # Test suite for POST /users/:user_id/operations
  describe 'POST /users/:user_id/operations' do
    let(:valid_attributes) { { title: 'Visit Narnia', status: 2, balance_id: 2 }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/users/#{user.id}/operations", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns the object created' do
        expect(json).to be_a(Hash)
      end
    end

    context 'when an invalid request' do
      before { post "/users/#{user.id}/operations", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Balance can't be blank, Title can't be blank, Title is invalid, Status can't be blank, Status is invalid/)
      end
    end
  end

  # Test suite for PUT /users/:user_id/operations/:id
  describe 'PUT /users/:user_id/operations/:id' do
    let(:valid_attributes) { { title: 'Mozart' }.to_json }

    before do
      put "/users/#{user.id}/operations/#{id}", params: valid_attributes, headers: headers
    end

    context 'when operation exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the operation' do
        updated_item = Operation.find(id)
        expect(updated_item.title).to match(/Mozart/)
      end
    end

    context 'when the operation does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Operation/)
      end
    end
  end

  # Test suite for DELETE /balances/:id
  describe 'DELETE /balances/:id' do
    before { delete "/users/#{user.id}/operations/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

RSpec.describe 'Operations API requested by NOT LOGGED IN USER' do
  let(:user) { create(:user, password_confirmation: 'foobar') }
  # Initialize the test data
  let!(:balance) { create(:balance, user_id: user.id) }
  let!(:operations) { create_list(:operation, 20, balance_id: balance.id, status: 1, user_id: user.id) }
  let(:balance_id) { balance.id }
  let(:id) { operations.first.id }
  let(:headers) { invalid_headers }

  # Test suite for GET /users/:user_id/operations
  describe 'GET /users/:user_id/operations' do
    before { get "/users/#{user.id}/operations", params: {}, headers: headers }

    context 'when operations exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all user operations' do
        expect(json.size).to eq(20)
      end
    end
  end

  # Test suite for GET /users/:user_id/operations/:id
  describe 'GET /users/:user_id/operations/:id' do
    before { get "/users/#{user.id}/operations/#{id}", params: {}, headers: headers }

    context 'when user operation exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the operation' do
        expect(json['id']).to eq(id)
      end
    end
  end

  # Test suite for POST /users/:user_id/operations
  describe 'POST /users/:user_id/operations' do
    let(:valid_attributes) { { title: 'Visit Narnia', status: 2, balance_id: 2 }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/users/#{user.id}/operations", params: valid_attributes, headers: headers
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the a failure message' do
        expect(json['message']).to match(/Missing token/)
      end
    end

    context 'when an invalid request' do
      before { post "/users/#{user.id}/operations", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Missing token/)
      end
    end
  end

  # Test suite for PUT /users/:user_id/operations/:id
  describe 'PUT /users/:user_id/operations/:id' do
    let(:valid_attributes) { { title: 'Mozart' }.to_json }

    before do
      put "/users/#{user.id}/operations/#{id}", params: valid_attributes, headers: headers
    end

    context 'when operation exists' do
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the a failure message' do
        expect(json['message']).to match(/Missing token/)
      end
    end

    context 'when the operation does not exist' do
      let(:id) { 0 }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the a failure message' do
        expect(json['message']).to match(/Missing token/)
      end
    end
  end

  # Test suite for DELETE /balances/:id
  describe 'DELETE /balances/:id' do
    before { delete "/users/#{user.id}/operations/#{id}", params: {}, headers: headers }

    it 'returns status code 422' do
      expect(response).to have_http_status(422)
    end

    it 'returns the a failure message' do
      expect(json['message']).to match(/Missing token/)
    end
  end
end

RSpec.describe 'Operations API requested by ADMIN' do
  let(:user) { create(:user, admin: true, password_confirmation: 'foobar') }
  # Initialize the test data
  let!(:balance) { create(:balance, user_id: user.id) }
  let(:operation) { create(:operation, user_id: user.id, balance_id: balance.id) }
  let!(:operations) { create_list(:operation, 20, balance_id: balance.id, status: 1, user_id: user.id) }
  let(:balance_id) { balance.id }
  let(:id) { operations.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /users/:user_id/operations
  describe 'GET /users/:user_id/operations' do
    before { get "/users/#{user.id}/operations", params: {}, headers: headers }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all user operations' do
        expect(json.size).to eq(20)
      end
    end
  end

  # Test suite for GET /users/:user_id/operations/:id
  describe 'GET /users/:user_id/operations/:id' do
    before { get "/users/#{user.id}/operations/#{id}", params: {}, headers: headers }

    context 'when user operation exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the operation' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when user operation does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Operation/)
      end
    end
  end

  # Test suite for POST /users/:user_id/operations
  describe 'POST /users/:user_id/operations' do
    let(:valid_attributes) { { title: 'Visit Narnia', status: 2, balance_id: 2 }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/users/#{user.id}/operations", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns the object created' do
        expect(json).to be_a(Hash)
      end
    end

    context 'when an invalid request' do
      before { post "/users/#{user.id}/operations", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Balance can't be blank, Title can't be blank, Title is invalid, Status can't be blank, Status is invalid/)
      end
    end
  end

  # Test suite for PUT /users/:user_id/operations/:id
  describe 'PUT /users/:user_id/operations/:id' do
    let(:valid_attributes) { { title: 'Mozart' }.to_json }

    before do
      put "/users/#{user.id}/operations/#{id}", params: valid_attributes, headers: headers
    end

    context 'when operation exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the operation' do
        updated_item = Operation.find(id)
        expect(updated_item.title).to match(/Mozart/)
      end
    end

    context 'when the operation does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Operation/)
      end
    end
  end

  # Test suite for DELETE /balances/:id
  describe 'DELETE /balances/:id' do
    before { delete "/users/#{user.id}/operations/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
# rubocop:enable Layout/LineLength
