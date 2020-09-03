class OperationsController < ApplicationController
  skip_before_action :authorize_request
  before_action :set_balance
  before_action :set_balance_operation, only: %i[show update destroy]

  # GET /balances/:balance_id/operations
  def index
    json_response(@balance.operations)
  end

  # GET /balances/:balance_id/operations/:id
  def show
    json_response(@operation)
  end

  # POST /balances/:balance_id/operations
  def create
    @operation = @balance.operations.create!(operation_params)
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

  def set_balance
    @balance = Balance.find(params[:balance_id])
  end

  def set_balance_operation
    @operation = @balance.operations.find_by!(id: params[:id]) if @balance
  end
end
