class AuthenticationController < ApplicationController
  def authenticate
    auth_token =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    response.headers['Authorization'] = auth_token
    response.headers['Content-Type'] = 'application/json'
    render response, status: :ok
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
