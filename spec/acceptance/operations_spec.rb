require 'acceptance_helper'

resource 'Operation', acceptance: true do
  let(:user) { create(:user, admin: true) }
  let!(:balance) { create(:balance, user_id: user.id) }
  let!(:operations) { create_list(:operation, 20, balance_id: 1, status: 1, user_id: user.id) }
  let(:balance_id) { balance.id }
  let(:id) { operations.first.id }
  let(:headers) { valid_headers }

  get 'users/:user_id/operations' do
    let(:user_id) { user.id }
    example_request 'Listing operations items' do
      explanation 'List all the operations from the given user'
      expect(status).to eq 200
    end

    example_request 'returns all user operations' do
      expect(JSON.parse(response_body).size).to eq(20)
    end
  end

  # get 'projects/:project_id/todos/:todo_id/items/:id' do
  #   let(:project_id) { project.id }
  #   let(:todo_id) { todo.id }
  #   let(:id) { todos.first.id }
  #   example_request 'Getting a specific item from the the todo list' do
  #     explanation 'Shows a specific item from the todo list'
  #     expect(status).to eq(200)
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