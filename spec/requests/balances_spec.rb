require 'rails_helper'

RSpec.describe 'Balances API requested by ADMIN', type: :request do
  let(:user) { create(:user, admin: true) }
  let!(:balances) { create_list(:balance, 10, user_id: user.id) }
  let(:balance_id) { balances.first.id }
  let(:headers) { valid_headers }

  describe 'GET /balances' do
    before { get '/balances', params: {}, headers: headers  }

    it 'returns balances' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /balances/:id' do
    before { get "/balances/#{balance_id}", params: {}, headers: headers  }

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
    let(:valid_attributes) do
      # send json payload
      { user_id: user.id.to_s, title: 'Learn Elm', total: 921978, category: 'x' }.to_json
    end

    context 'when request is valid' do
      before { post '/balances', params: valid_attributes, headers: headers }

      it 'creates a balance' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      let(:invalid_attributes) { { title: nil, total: nil, category: nil }.to_json }
      before { post '/balances', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Title can't be blank, Total can't be blank, Category can't be blank/)
      end
    end
  end

  describe 'PUT /balances/:id' do
    let(:valid_attributes) { { title: 'Learn Python', total: 921978, category: 'x' }.to_json }

    context 'when the record exists' do
      before { put "/balances/#{balance_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /balances/:id' do
    before { delete "/balances/#{balance_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

RSpec.describe 'Balances API requested by USER', type: :request do
  let(:user) { create(:user) }
  let!(:balances) { create_list(:balance, 10, user_id: user.id) }
  let(:balance_id) { balances.first.id }
  let(:headers) { valid_headers }

  describe 'GET /balances' do
    before { get '/balances', params: {}, headers: headers  }

    it 'returns balances' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /balances/:id' do
    before { get "/balances/#{balance_id}", params: {}, headers: headers  }

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
    let(:valid_attributes) do
      # send json payload
      { user_id: user.id.to_s, title: 'Learn Elm', total: 921978, category: 'x' }.to_json
    end

    context 'when request is valid' do
      before { post '/balances', params: valid_attributes, headers: headers }

      it 'unauthorized to creates a balance' do
        expect(json['message']).to eq('Unauthorized request')
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when request is invalid' do
      let(:invalid_attributes) { { title: nil, total: nil, category: nil }.to_json }
      before { post '/balances', params: invalid_attributes, headers: headers }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end

      it 'returns a authorization failure message' do
        expect(response.body)
          .to match(/Unauthorized request/)
      end
    end
  end

  describe 'PUT /balances/:id' do
    let(:valid_attributes) { { title: 'Learn Python', total: 921978, category: 'x' }.to_json }

    context 'when the record exists' do
      before { put "/balances/#{balance_id}", params: valid_attributes, headers: headers }

      it 'doesnt allow updates the record to user' do
        expect(response.body).to match(/Unauthorized request/)
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE /balances/:id' do
    before { delete "/balances/#{balance_id}", params: {}, headers: headers }

    it 'returns status code 401' do
      expect(response).to have_http_status(401)
    end

    it 'doesnt allow destroy the record to user' do
      expect(response.body).to match(/Unauthorized request/)
    end
  end
end