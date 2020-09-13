module ControllerSpecHelper
  # generate tokens from user id
  def token_generator(user_id, user_admin)
    JsonWebToken.encode(user_id: user_id, user_admin: user_admin)
  end

  # generate expired tokens from user id
  def expired_token_generator(user_id, user_admin)
    JsonWebToken.encode({ user_id: user_id, user_admin: user_admin }, (Time.now.to_i - 10))
  end

  # return valid headers
  def valid_headers
    {
      'Authorization' => token_generator(user.id, user.admin),
      'Content-Type' => 'application/json'
    }
  end

  # return invalid headers
  def invalid_headers
    {
      'Authorization' => nil,
      'Content-Type' => 'application/json'
    }
  end
end
