require 'acceptance_helper'

resource 'Operations' do
  let(:user) { create(:user) }
  let(:balance) { create(:balance, user_id: user.id) }
  let(:operation) {create(:operation, user_id: user.id, balance_id: balance.id ) }
  let(:user_id) { user.id }
  let(:operation_id) { operation.id }
  let(:headers) { valid_headers }
  
  explanation 'Operations resources. '

  header "Content-Type", "application/json"


  get 'users/:user_id/operations' do

    parameter :user_id, 'This parameter specifies the user from which we want to extract the operations.', required: true

    context '200' do
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

    parameter :user_id, 'This parameter specifies the user from which we want to extract the operations.', required: true
    parameter :operation_id, 'Specifies which specific operation we want to extract.', required: true

    context '200' do
      example_request 'Get specific user operation.' do
        explanation 'Get a specific operation from the specified user. This an open endpoint to extract data.'
        expect(status).to eq 200
      end
    end

    context "404" do
      let(:operation_id) { 0 }
      
      example_request 'Operation is not found' do
        expect(status).to eq(404)
      end
    end
  end

  # post 'users/:user_id/operations' do

  #   parameter :user_id, 'This parameter specifies the user from which we want to extract the operations.', required: true
  #   parameter :title, 'The title of the operation', required: true
  # #   parameter :status, 'Active or passive', required: true
  # #   parameter :balance_id, 'Balance the operation belongs to', required: true

  #   context '200' do
  #     example_request 'Get user operations.' do
  #       explanation 'Get all the operations from a specified user. This an open endpoint to extract data.'
  #       expect(status).to eq 200
  #     end
  #   end

  #   context "404" do
  #     let(:user_id) { 0 }
      
  #     example_request 'User is not found' do
  #       expect(status).to eq(404)
  #     end
  #   end
  # end

  # post 'users/:user_id/operations' do

  #   parameter :title, 'The title of the operation', required: true
  #   parameter :status, 'Active or passive', required: true
  #   parameter :balance_id, 'Balance the operation belongs to', required: true

  #   context '201' do
  #     example_request 'Creating a new item' do
  #       explanation 'Adds a new item to the selected todo'
  #       do_request(title: 'Repetitions', status: false, balance_id: balance.id)
  #       expect(status).to eq(201)
  #     end
  #   end
  # end

  # post 'users/:user_id/operations' do

  #   parameter :title, 'The title of the operation', required: true
  #   parameter :status, 'Active or passive', required: true
  #   parameter :balance_id, 'Balance the operation belongs to', required: true

  #   context "201" do
  #     example_request 'Create an operation' do
  #       explanation 'Get a specific operation from the specified user. This an open endpoint to extract data.'
  #       expect(status).to eq(201)
  #     end
  #   end

    # context "400" do
    #   let(:id) { "a" }

    #   example_request 'Invalid request' do
    #     expect(status).to eq(400)
    #   end
    # end
    
    # context "404" do
    #   let(:id) { 0 }
      
    #   example_request 'Order is not found' do
    #     expect(status).to eq(404)
    #   end
    # end
  # end

  # get 'projects/:project_id/todos/:todo_id/items/:id' do
  #   let(:project_id) { project.id }
  #   let(:todo_id) { todo.id }
  #   let(:id) { todos.first.id }
  #   context '200' do
  #     example_request 'Getting a specific item from the the todo list' do
  #       explanation 'Shows a specific item from the todo list'
  #       expect(status).to eq(200)
  #     end
  #   end
  # end

  # post 'projects/:project_id/todos/:todo_id/items' do
  #   route_summary 'This is used to create todo items.'
  #   let(:project_id) { project.id }
  #   let(:todo_id) { todo.id }

  #   parameter :name, 'Item name'
  #   parameter :done, 'Completion Checker'
  #   parameter :todo_id, 'Todo id'

  #   example_request 'Creating a new item' do
  #     explanation 'Adds a new item to the selected todo'
  #     do_request(name: 'Repetitions', done: false, todo_id: todo.id)
  #     expect(status).to eq(201)
  #   end
  # end

  # put 'projects/:project_id/todos/:todo_id/items/:id' do
  #   route_summary 'This is used to update todo items.'
  #   let(:project_id) { project.id }
  #   let(:todo_id) { todo.id }
  #   let(:id) { todos.first.id }

  #   parameter :name, 'Item name'
  #   parameter :done, 'Completion Checker'
  #   parameter :todo_id, 'Todo id'

  #   example_request 'Updating a specific todo item.' do
  #     explanation 'Edits an item from the selected todo'
  #     do_request(name: 'Seconds', done: true, todo_id: todo.id)
  #     expect(status).to eq(204)
  #   end
  # end
end