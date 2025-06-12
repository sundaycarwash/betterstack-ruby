module BetterStack
  class Configuration
    attr_accessor :api_token, :base_url, :timeout, :retries

    def initialize
      @base_url = "https://uptime.betterstack.com/api/v2"
      @timeout = 30
      @retries = 3
    end

    def valid?
      !api_token.nil? && !api_token.empty?
    end
  end
end
