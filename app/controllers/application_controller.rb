class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_csrf_cookie

  include ExceptionHandler
  include ::SessionsHelper

  def health
    head :ok
  end

  private

  def logged_in_user
    head :unauthorized unless logged_in?
  end

  def set_csrf_cookie
    cookies['CSRF-TOKEN'] = form_authenticity_token
  end
end
