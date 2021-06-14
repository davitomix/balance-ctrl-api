class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :params_not_nil

  def create
    user = User.find_by(email: params[:user][:email]).try(:authenticate, params[:user][:password])

    if user
      session[:user_id] = user.id
      render json: {
        logged_in: true,
        user: user.serializable_hash(
          except: %i[
            password_digest
            admin
            created_at
            updated_at
          ]
        )
      }, status: :ok
    else
      head :unauthorized
    end
  end

  private

  def params_not_nil
    head :unauthorized if params[:user].blank?
  end
end
