class OperationsController < ApplicationController
  skip_before_action :authorize_admin_request

  def index
    render json: { operations: current_user.operations }, status: :ok
  end

  def show
    render json: OperationSerializer.new.serialize(find_operation), status: :ok
  end

  def create
    operation = current_user.operations.create!(operation_params)
    render json: operation, status: :created
  end

  def update
    find_operation.update!(operation_params)
    head :no_content
  end

  def destroy
    find_operation.destroy
    head :no_content
  end

  private

  def find_operation
    Operation.find(params[:id])
  end

  def operation_params
    params.require(:operation).permit(:title, :status, :balance_id)
  end
end
