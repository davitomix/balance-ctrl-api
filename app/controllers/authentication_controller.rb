class AuthenticationController < ApplicationController
  skip_before_action :authorize_admin
  skip_before_action :authorize_request

  def authenticate
    auth_token =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    user = User.find_by!(email: auth_params[:email])
    render json: { auth_token: auth_token, user_id: user.id }, status: :ok
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
