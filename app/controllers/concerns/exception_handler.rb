module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches
  class AuthenticationError < StandardError;end
  class MissingToken < StandardError;end
  class InvalidToken < StandardError;end

  included do 
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unauthorized_request

    # Defining Custom Handlers
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :invalid_token
  end

  private
  def four_twenty_two(e)
      json_response({message: e.message}, :unprocessable_entity)
    end
   
    def invalid_token(e)
      json_response({message: "Invalid authenticity token"}, :unauthorized)
    end

    def unauthorized_request(e)
      json_response({message: e.message}, :unauthorized)
    end

    def record_not_found(e)
      json_response({message: e.message}, :not_found)
    end
end