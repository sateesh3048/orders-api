class AuthorizationApiRequest
  attr_reader :headers
  def initialize(headers = {})
    @headers = headers 
  end

  def call
    {
      user: user
    }
  end

  private

  def user
    begin
      @user ||= User.find(decode_auth_token[:user_id]) if decode_auth_token
    rescue ActiveRecord::RecordNotFound => e
      p "I am inside not found"
      p e.message
      raise(
        ExceptionHandler::InvalidToken,
        ("#{Message.invalid_token} #{e.message}")
      ) 
    end   
  end

  def decode_auth_token
    @decode_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      raise(ExceptionHandler::MissingToken, Message.missing_token)
    end
  end
end