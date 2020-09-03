class BalancesController < ApplicationController
  skip_before_action :authorize_request, only: %i[index show]
  before_action :admin_user, only: %i[create update destroy]
  before_action :set_user
  before_action :set_user_balance, only: %i[show update destroy]
  # GET users/user_id/balance
  def index
    json_response(@user.balances)
  end

  # POST /users/balances
  def create
    @balance = current_user.balances.create!(balance_params)
    json_response(@balance, :created)
  end

  # GET /users/balances/:id
  def show
    json_response(@balance)
  end

  # PUT /users/balances/:id
  def update
    @balance.update(balance_params)
    head :no_content
  end

  # DELETE /users/balances/:id
  def destroy
    @balance.destroy
    head :no_content
  end

  private

  def balance_params
    # whitelist params
    params.permit(:title, :total, :category, :user_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_user_balance
    @balance = @user.balances.find_by!(id: params[:id]) if @user
  end

  # Confirms an admin user.
  def admin_user
    raise(ExceptionHandler::AuthenticationError, Message.unauthorized) unless current_user.admin?
  end
end
