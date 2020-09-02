require 'rails_helper'

RSpec.describe 'Operations API' do
  # Initialize the test data
  let!(:balance) { create(:balance) }
  let!(:operations) { create_list(:operation, 20, balance_id: balance.id, status: 1) }
  let(:balance_id) { balance.id }
  let(:id) { operations.first.id }

  # Test suite for GET /balances/:balance_id/operations
  describe 'GET /balances/:balance_id/operations' do
    before { get "/balances/#{balance_id}/operations" }

    context 'when balance exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all balance operations' do
        expect(json.size).to eq(20)
      end
    end

    context 'when balance does not exist' do
      let(:balance_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Balance/)
      end
    end
  end

  # Test suite for GET /balances/:balance_id/operations/:id
  describe 'GET /balances/:balance_id/operations/:id' do
    before { get "/balances/#{balance_id}/operations/#{id}" }

    context 'when balance operation exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the operation' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when balance operation does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Operation/)
      end
    end
  end

  # Test suite for PUT /balances/:balance_id/operations
  describe 'POST /balances/:balance_id/operations' do
    let(:valid_attributes) { { title: 'Visit Narnia', status: 2, balance_id: nil } }

    context 'when request attributes are valid' do
      before { post "/balances/#{balance_id}/operations", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/balances/#{balance_id}/operations", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Title can't be blank, Status can't be blank/)
      end
    end
  end

  # Test suite for PUT /balances/:balance_id/operations/:id
  describe 'PUT /balances/:balance_id/operations/:id' do
    let(:valid_attributes) { { title: 'Mozart' } }

    before { put "/balances/#{balance_id}/operations/#{id}", params: valid_attributes }

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
    before { delete "/balances/#{balance_id}/operations/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end