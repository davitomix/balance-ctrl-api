module SessionsHelper
  def current_user
    return unless (user_id = session[:user_id])

    @current_user ||= User.find_by(id: user_id)
  end

  def logged_in?
    !current_user.nil?
  end
end
