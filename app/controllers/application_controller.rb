class ApplicationController < ActionController::API
  include ExceptionHandler
  include SessionsHelper

  private

  def logged_in_user
    head :unauthorized unless logged_in?
  end
end
