module BetterStack
  class Error < StandardError; end
  class ConfigurationError < Error; end
  class APIError < Error
    attr_reader :status, :response_body

    def initialize(message, status: nil, response_body: nil)
      super(message)
      @status = status
      @response_body = response_body
    end
  end
  class NotFoundError < APIError; end
  class UnauthorizedError < APIError; end
  class RateLimitError < APIError; end
  class ValidationError < APIError; end
end
