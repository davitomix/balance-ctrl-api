class UsersController < ApplicationController
  def create
    user = User.create!(user_params)

    render json: { id: user.id }, status: :created
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
