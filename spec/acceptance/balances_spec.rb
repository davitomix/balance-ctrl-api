# rubocop:disable Layout/LineLength
# rubocop:disable Metrics/BlockLength
require 'acceptance_helper'
resource 'Balances' do
  authentication :basic, :api_key, description: 'Api Key description'
  let(:user) { create(:user, admin: true) }
  let(:balance) { create(:balance, user_id: user.id) }
  let(:operation) { create(:operation, user_id: user.id, balance_id: balance.id, status: true) }
  let!(:operations) { create_list(:operation, 20, user_id: user.id, balance_id: balance.id, status: true) }

  explanation 'Operations resources. '

  before do
    header 'Authorization', token_generator(user.id, user.admin)
    header 'Content-Type', 'application/json'
  end

  get 'users/:user_id/balances' do
    parameter :user_id, 'user_id', required: true

    context '200' do
      let(:user_id) { user.id }

      example_request 'Get index balances.' do
        explanation 'Get all the balances specified by the admin. This is a open endpoint to extract data.'
        expect(status).to eq 200
      end
    end

    context '404' do
      let(:user_id) { 0 }

      example_request 'Balance is not found' do
        expect(status).to eq(404)
      end
    end
  end

  get 'users/:user_id/balances/:balance_id' do
    let(:user_id) { user.id }

    parameter :user_id, 'user_id', required: true
    parameter :balance_id, 'operation_id', required: true

    context '200' do
      let(:balance_id) { balance.id }

      example_request 'Get specific admin balance.' do
        explanation 'Get a specific balance. This is a open endpoint to extract data.'
        expect(status).to eq 200
      end
    end

    context '404' do
      let(:balance_id) { 0 }

      example_request 'Operation is not found' do
        explanation 'Not found.'
        expect(status).to eq(404)
      end
    end
  end

  post '/users/:user_id/balances' do
    parameter :user_id, 'user_id', required: true
    parameter :title, 'title', required: true
    parameter :category, 'category', required: true
    parameter :total, 'total', required: true

    context '201' do
      example 'Create a balance' do
        explanation 'When given the correct params it creates a balance. This operation requires an admin in user.'
        request = {
          title: 'Title',
          total: 10_000,
          category: 'example',
          user_id: user.id
        }

        do_request(request)

        expect(status).to eq(201)
      end
    end
  end

  put '/users/:user_id/balances/:balance_id' do
    parameter :user_id, 'user_id', required: true
    parameter :title, 'title', required: true
    parameter :category, 'category', required: true
    parameter :total, 'total', required: true

    context '204' do
      let(:balance_id) { balance.id }

      example 'Update a balance' do
        explanation 'When given the correct params it updates a balance. This operation requires an admin in user.'
        request = {
          title: 'Updated',
          total: 10_000,
          category: 'example',
          user_id: user.id
        }

        do_request(request)

        expect(status).to eq(204)
      end
    end

    context '404' do
      let(:balance_id) { 0 }

      example_request 'Operation is not found' do
        explanation 'Not found.'
        expect(status).to eq(404)
      end
    end
  end

  delete '/users/:user_id/balances/:balance_id' do
    parameter :user_id, 'user_id', required: true
    parameter :title, 'title', required: true
    parameter :category, 'category', required: true
    parameter :total, 'total', required: true

    context '204' do
      let(:balance_id) { balance.id }

      example 'Delete a operation' do
        explanation 'When given the correct params it deletes an operation, returns no content. This operation requires an admin in user..'
        request = {
          title: 'To delete',
          total: 10_000,
          category: 'example',
          user_id: user.id
        }

        do_request(request)

        expect(status).to eq(204)
      end
    end

    context '404' do
      let(:balance_id) { 0 }

      example_request 'Operation is not found' do
        explanation 'Not found.'
        expect(status).to eq(404)
      end
    end
  end
end
# rubocop:enable Layout/LineLength
# rubocop:enable Metrics/BlockLength
