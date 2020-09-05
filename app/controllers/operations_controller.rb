class OperationsController < ApplicationController
  skip_before_action :authorize_request, only: %i[index show]
  before_action :set_user
  before_action :set_operation, only: %i[show update destroy]

  # GET /balances/:balance_id/operations
  def index
    json_response(@user.operations)
  end

  # GET /balances/:balance_id/operations/:id
  def show
    json_response(@operation)
  end

  # POST /balances/:balance_id/operations
  def create
    @operation = @user.operations.create!(operation_params)
    json_response(@operation, :created)
  end

  # PUT /balances/:balance_id/operations/:id
  def update
    @operation.update(operation_params)
    head :no_content
  end

  # DELETE /balances/:balance_id/operations/:id
  def destroy
    @operation.destroy
    head :no_content
  end

  private

  def operation_params
    params.permit(:title, :status, :balance_id)
  end

  def set_user
    @user = User.find_by!(id: params[:user_id])
  end

  def set_operation
    @operation = @user.operations.find_by!(id: params[:id]) if @user
  end
end
