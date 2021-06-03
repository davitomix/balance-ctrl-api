class ApplicationController < ActionController::API
  include ExceptionHandler

  before_action :current_user

  private

  def current_user
    @current_user ||= User.first
  end
end
