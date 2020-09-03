class BalancesController < ApplicationController
  before_action :admin_user, only: [:create, :update, :destroy]
  before_action :set_balance, only: [:show, :update, :destroy]
  # GET /todos
  def index
    @balances = current_user.balances
    json_response(@balances)
  end

  # POST /todos
  def create
    @balance = current_user.balances.create!(balance_params)
    json_response(@balance, :created)
  end

  # GET /todos/:id
  def show
    json_response(@balance)
  end

  # PUT /todos/:id
  def update
    @balance.update(balance_params)
    head :no_content
  end

  # DELETE /todos/:id
  def destroy
    @balance.destroy
    head :no_content
  end

  private

  def balance_params
    # whitelist params
    params.permit(:title, :total, :category)
  end

  def set_balance
    @balance = Balance.find(params[:id])
  end

  # Confirms an admin user.
  def admin_user
    json_response({error: 'Not Authorized'}, :unauthorized) unless current_user.admin?
  end
end
