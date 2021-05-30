class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :authorize_request
  before_action :authorize_admin

  attr_reader :current_user

  private

  def authorize_request
    @current_user = AuthorizeApiRequest.new(request.headers).call[:user]
  end

  def authorize_admin
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials) unless @current_user.admin?
  end
end
