class JsonWebToken
  #Secret to encode and decode token
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
    # Set expire as 24 hours from now
    payload[:exp] = exp.to_i
    
    #Sign token with application secret
    JWT.encode(payload, HMAC_SECRET)

  end

  def self.decode(token)
    begin
      #Get payload; first index in decoded Array
      body = JWT.decode(token, HMAC_SECRET)[0]
      HashWithIndifferentAccess.new body
    rescue JWT::DecodeError => e
      p "Invalid token error message json web toke"
      p e.message
      raise ExceptionHandler::InvalidToken, e.message
    end
  end
end