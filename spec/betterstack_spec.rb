require "spec_helper"

RSpec.describe BetterStack do
  it "has a version number" do
    expect(BetterStack::VERSION).not_to be nil
  end

  describe ".configure" do
    it "allows configuration of api_token" do
      BetterStack.configure do |config|
        config.api_token = "new_token"
      end

      expect(BetterStack.configuration.api_token).to eq("new_token")
    end

    it "allows configuration of timeout" do
      BetterStack.configure do |config|
        config.timeout = 60
      end

      expect(BetterStack.configuration.timeout).to eq(60)
    end
  end

  describe ".client" do
    it "returns a client instance" do
      expect(BetterStack.client).to be_a(BetterStack::Client)
    end

    it "memoizes the client" do
      client1 = BetterStack.client
      client2 = BetterStack.client
      expect(client1).to eq(client2)
    end
  end

  describe ".reset_client!" do
    it "resets the memoized client" do
      client1 = BetterStack.client
      BetterStack.reset_client!
      client2 = BetterStack.client
      expect(client1).not_to eq(client2)
    end
  end
end
