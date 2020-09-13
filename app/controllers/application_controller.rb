class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  # called before every action on controllers
  before_action :authorize_request
  before_action :authorize_admin_request
  attr_reader :current_user

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = AuthorizeApiRequest.new(request.headers).call[:user]
  end

  # rubocop:disable Style/GuardClause
  def authorize_admin_request
    unless AuthorizeApiRequest.new(request.headers).call[:admin]
      raise(ExceptionHandler::AuthenticationError, Message.unauthorized)
    end
  end
  # rubocop:enable Style/GuardClause
end
