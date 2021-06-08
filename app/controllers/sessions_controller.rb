class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:user][:email]).try(:authenticate, params[:user][:password])

    if user
      session[:user_id] = user.id
      render json: {
        logged_in: true,
        user: user.serializable_hash(except: %i[
                                       password_digest
                                       admin
                                       created_at
                                       updated_at
                                     ])
      }, status: :ok
    else
      head :unauthorized
    end
  end
end
