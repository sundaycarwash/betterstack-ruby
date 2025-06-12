require "faraday"
require "faraday/retry"
require "json"
require_relative "betterstack/version"
require_relative "betterstack/configuration"
require_relative "betterstack/client"
require_relative "betterstack/error"
require_relative "betterstack/resources/base"
require_relative "betterstack/resources/monitor"
require_relative "betterstack/resources/heartbeat"
require_relative "betterstack/resources/status_page"
require_relative "betterstack/resources/incident"

module BetterStack
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    def client
      @client ||= Client.new(configuration)
    end

    def reset_client!
      @client = nil
    end
  end
end
