class AuthenticationController < ApplicationController
  def authenticate
    head :ok
  end

  private

  def auth_params
    params.require(:user).permit(:email, :password)
  end
end
