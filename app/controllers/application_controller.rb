class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include ExceptionHandler
  include SessionsHelper

  def health
    head :ok
  end

  private

  def logged_in_user
    head :unauthorized unless logged_in?
  end
end
