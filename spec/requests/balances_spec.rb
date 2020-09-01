require 'rails_helper'

RSpec.describe 'Balances API', type: :request do
  let!(:balances) { create_list(:balance, 10) }
  let(:balance_id) { balances.first.id }

  describe 'GET /balances' do
    before { get '/balances' }

    it 'returns balances' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /balances/:id' do
    before { get "/balances/#{balance_id}" }

    context 'when the record exists' do
      it 'returns the balance' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(balance_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:balance_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Balance/)
      end
    end
  end

  describe 'POST /balances' do
    let(:valid_attributes) { { user_id: '1', title: 'Learn Elm', total: 921978, category: 'x' } }

    context 'when request is valid' do
      before { post '/balances', params: valid_attributes }

      it 'creates a balance' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post '/balances', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: User can't be blank, Total can't be blank, Category can't be blank/)
      end
    end
  end

  describe 'PUT /balances/:id' do
    let(:valid_attributes) { { title: 'Learn Python', total: 921978, category: 'x' }.to_json }

    context 'when the record exists' do
      before { put "/balances/#{balance_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /balances/:id' do
    before { delete "/balances/#{balance_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end