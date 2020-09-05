require 'acceptance_helper'

resource 'Operations' do
  authentication :basic, :api_key, :description => "Api Key description"
  let(:user) { create(:user) }
  let(:balance) { create(:balance, user_id: user.id) }
  let(:operation) {create(:operation, user_id: user.id, balance_id: balance.id, status: true) }
  let!(:operations) { create_list(:operation, 20, user_id: user.id, balance_id: balance.id, status: true) }

  explanation 'Operations resources. '

  before do
    header 'Authorization', token_generator(user.id)
    header 'Content-Type', 'application/json'
  end
  

  get 'users/:user_id/operations' do

    parameter :user_id, 'user_id', required: true

    context '200' do
      let(:user_id) { user.id }

      example_request 'Get user operations.' do
        explanation 'Get all the operations from a specified user. This an open endpoint to extract data.'
        expect(status).to eq 200
      end
    end

    context "404" do
      let(:user_id) { 0 }
      
      example_request 'User is not found' do
        expect(status).to eq(404)
      end
    end
  end

  get 'users/:user_id/operations/:operation_id' do
    let(:user_id) { user.id }

    parameter :user_id, 'user_id', required: true
    parameter :operation_id, 'operation_id',required: true 

    context '200' do
      let(:operation_id) { operation.id }

      example_request 'Get specific user operation.' do
        explanation 'Get a specific operation from the specified user. This an open endpoint to extract data.'
        expect(status).to eq 200
      end
    end

    context "404" do
      let(:operation_id) { 0 }
      
      example_request 'Operation is not found' do
        explanation 'Not found.'
        expect(status).to eq(404)
      end
    end
  end

  post '/users/:user_id/operations' do 

    parameter :user_id, 'user_id', required: true
    parameter :title, 'title', required: true
    parameter :_status, '_status', required: true
    parameter :balance_id, 'balance_id', required: true

    context "201" do
      example 'Create a operation' do
        explanation 'When given the correct params it creates an operation. This endpoint requires a logged in user.'
        request = {
          title: 'Title',
          status: true,
          balance_id: 3,
          user_id: user.id,
        }
        
        do_request(request)

        expect(status).to eq(201)
      end
    end
  end  

  put '/users/:user_id/operations/:operation_id' do 

    parameter :user_id, 'user_id', required: true
    parameter :operation_id, 'operation_id', required: true
    parameter :title, 'title', required: true
    parameter :_status, '_status', required: true
    parameter :balance_id, 'balance_id', required: true

    context "204" do
      let(:operation_id) { operation.id }

      example 'Update a operation' do
        explanation 'When given the correct params it updates an operation, returns no content. This endpoint requires a logged in user.'
        request = {
          title: 'Updated',
          status: true,
          balance_id: 3,
          user_id: user.id,
        }
        
        do_request(request)

        expect(status).to eq(204)
      end
    end

    context "404" do
      let(:operation_id) { 0 }
      
      example_request 'Operation is not found' do
        explanation 'Not found.'
        expect(status).to eq(404)
      end
    end
  end 

  delete '/users/:user_id/operations/:operation_id' do 

    parameter :user_id, 'user_id', required: true
    parameter :operation_id, 'operation_id', required: true
    parameter :title, 'title', required: true
    parameter :_status, '_status', required: true
    parameter :balance_id, 'balance_id', required: true

    context "204" do
      let(:operation_id) { operation.id }
      
      example 'Delete a operation' do
        explanation 'When given the correct params it deletes an operation, returns no content. This endpoint requires a logged in user.'
        request = {
          title: 'Updated',
          status: true,
          balance_id: 3,
          user_id: user.id,
        }
        
        do_request(request)

        expect(status).to eq(204)
      end
    end

    context "404" do
      let(:operation_id) { 0 }
      
      example_request 'Operation is not found' do
        explanation 'Not found.'
        expect(status).to eq(404)
      end
    end
  end 
end