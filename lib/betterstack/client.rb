module BetterStack
  class Client
    attr_reader :configuration

    def initialize(configuration = nil)
      @configuration = configuration || BetterStack.configuration
      raise ConfigurationError, "API token is required" unless @configuration&.valid?
    end

    def monitors
      @monitors ||= Resources::Monitor.new(self)
    end

    def heartbeats
      @heartbeats ||= Resources::Heartbeat.new(self)
    end

    def status_pages
      @status_pages ||= Resources::StatusPage.new(self)
    end

    def incidents
      @incidents ||= Resources::Incident.new(self)
    end

    def connection
      @connection ||= Faraday.new(url: configuration.base_url) do |conn|
        conn.request :json
        conn.request :retry, {
          max: configuration.retries,
          interval: 0.5,
          interval_randomness: 0.5,
          backoff_factor: 2
        }
        conn.response :json
        conn.headers["Authorization"] = "Bearer #{configuration.api_token}"
        conn.headers["User-Agent"] = "BetterStack Ruby Gem #{VERSION}"
        conn.options.timeout = configuration.timeout
      end
    end

    def get(path, params = {})
      response = connection.get(path, params)
      handle_response(response)
    end

    def post(path, body = {})
      response = connection.post(path, body)
      handle_response(response)
    end

    def put(path, body = {})
      response = connection.put(path, body)
      handle_response(response)
    end

    def patch(path, body = {})
      response = connection.patch(path, body)
      handle_response(response)
    end

    def delete(path)
      response = connection.delete(path)
      handle_response(response)
    end

    private

    def handle_response(response)
      case response.status
      when 200..299
        response.body
      when 401
        raise UnauthorizedError.new("Unauthorized", status: response.status, response_body: response.body)
      when 404
        raise NotFoundError.new("Resource not found", status: response.status, response_body: response.body)
      when 422
        raise ValidationError.new(extract_error_message(response), status: response.status, response_body: response.body)
      when 429
        raise RateLimitError.new("Rate limit exceeded", status: response.status, response_body: response.body)
      else
        raise APIError.new("API Error: #{response.status}", status: response.status, response_body: response.body)
      end
    end

    def extract_error_message(response)
      if response.body.is_a?(Hash) && response.body["errors"]
        response.body["errors"].join(", ")
      else
        "Validation failed"
      end
    end
  end
end
