class BalancesController < ApplicationController
  before_action :logged_in_user

  def index
    render json: { balances: current_user.balances }, status: :ok
  end

  def create
    balance = current_user.balances.create!(balance_params)
    render json: { balance: balance }, status: :created
  end

  def show
    render json: { balance: find_balance }, status: :ok
  end

  def update
    find_balance.update!(balance_params)
    head :no_content
  end

  def destroy
    find_balance.destroy
    head :no_content
  end

  private

  def find_balance
    Balance.find(params[:id])
  end

  def balance_params
    params.require(:balance).permit(:title, :total, :category, :user_id)
  end
end
