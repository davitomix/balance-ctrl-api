class SessionsController < ApplicationController
  def create
    # binding.pry
    user = User.find_by(email: params[:user][:email]).try(:authenticate, params[:user][:password])

    if user
      session[:user_id] = user.id
      # binding.pry
      render json: {
        logged_in: true,
        user: user
      }, status: :ok
    else
      render json: { status: :unauthorized }
    end
  end
end
