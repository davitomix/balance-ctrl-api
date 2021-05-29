class BalancesController < ApplicationController
  skip_before_action :authorize_request, only: %i[index show]
  skip_before_action :authorize_admin_request, only: %i[index show]

  before_action :set_user
  before_action :set_balance, only: %i[update destroy]

  def index
    json_response(User.first.balances)
  end

  def create
    @balance = current_user.balances.create!(balance_params)
    json_response(@balance, :created)
  end

  def show
    json_response(User.first.balances.find(params[:id]))
  end

  def update
    @balance.update(balance_params)
    head :no_content
  end

  def destroy
    @balance.destroy
    head :no_content
  end

  private

  def balance_params
    params.permit(:title, :total, :category)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_balance
    @balance = @user.balances.find(params[:id]) if @user
  end
end
