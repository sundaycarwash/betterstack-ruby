require "bundler/setup"
require "betterstack"
require "webmock/rspec"
require "vcr"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    BetterStack.reset_client!
    BetterStack.configure do |c|
      c.api_token = "test_token"
    end
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data("<API_TOKEN>") { BetterStack.configuration.api_token }
end

WebMock.disable_net_connect!(allow_localhost: true)
