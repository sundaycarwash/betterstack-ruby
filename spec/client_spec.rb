require "spec_helper"

RSpec.describe BetterStack::Client do
  let(:configuration) { BetterStack::Configuration.new.tap { |c| c.api_token = "test_token" } }
  subject { described_class.new(configuration) }

  describe "#initialize" do
    context "with valid configuration" do
      it "initializes successfully" do
        expect(subject.configuration).to eq(configuration)
      end
    end

    context "with invalid configuration" do
      let(:invalid_config) { BetterStack::Configuration.new }

      it "raises ConfigurationError" do
        expect { described_class.new(invalid_config) }.to raise_error(BetterStack::ConfigurationError)
      end
    end
  end

  describe "resource methods" do
    it "returns monitor resource" do
      expect(subject.monitors).to be_a(BetterStack::Resources::Monitor)
    end

    it "returns heartbeat resource" do
      expect(subject.heartbeats).to be_a(BetterStack::Resources::Heartbeat)
    end

    it "returns status_pages resource" do
      expect(subject.status_pages).to be_a(BetterStack::Resources::StatusPage)
    end

    it "returns incidents resource" do
      expect(subject.incidents).to be_a(BetterStack::Resources::Incident)
    end
  end

  describe "HTTP methods", :vcr do
    let(:monitor_data) { { "data" => { "id" => "123", "attributes" => { "name" => "Test Monitor" } } } }

    before do
      stub_request(:get, "https://uptime.betterstack.com/api/v2/monitors")
        .with(headers: { "Authorization" => "Bearer test_token" })
        .to_return(status: 200, body: monitor_data.to_json, headers: { "Content-Type" => "application/json" })
    end

    describe "#get" do
      it "makes a GET request" do
        response = subject.get("monitors")
        expect(response).to eq(monitor_data)
      end
    end

    describe "#post" do
      let(:create_data) { { "name" => "New Monitor", "url" => "https://example.com" } }

      before do
        stub_request(:post, "https://uptime.betterstack.com/api/v2/monitors")
          .with(
            headers: { "Authorization" => "Bearer test_token" },
            body: create_data.to_json
          )
          .to_return(status: 201, body: monitor_data.to_json, headers: { "Content-Type" => "application/json" })
      end

      it "makes a POST request" do
        response = subject.post("monitors", create_data)
        expect(response).to eq(monitor_data)
      end
    end
  end

  describe "error handling" do
    context "when API returns 401" do
      before do
        stub_request(:get, "https://uptime.betterstack.com/api/v2/monitors")
          .to_return(status: 401, body: { "error" => "Unauthorized" }.to_json)
      end

      it "raises UnauthorizedError" do
        expect { subject.get("monitors") }.to raise_error(BetterStack::UnauthorizedError)
      end
    end

    context "when API returns 404" do
      before do
        stub_request(:get, "https://uptime.betterstack.com/api/v2/monitors/999")
          .to_return(status: 404, body: { "error" => "Not found" }.to_json)
      end

      it "raises NotFoundError" do
        expect { subject.get("monitors/999") }.to raise_error(BetterStack::NotFoundError)
      end
    end

    context "when API returns 422" do
      before do
        stub_request(:post, "https://uptime.betterstack.com/api/v2/monitors")
          .to_return(status: 422, body: { "errors" => ["Name can't be blank"] }.to_json)
      end

      it "raises ValidationError with error message" do
        expect { subject.post("monitors", {}) }.to raise_error(BetterStack::ValidationError)
      end
    end

    context "when API returns 429" do
      before do
        stub_request(:get, "https://uptime.betterstack.com/api/v2/monitors")
          .to_return(status: 429, body: { "error" => "Rate limit exceeded" }.to_json)
      end

      it "raises RateLimitError" do
        expect { subject.get("monitors") }.to raise_error(BetterStack::RateLimitError)
      end
    end

    context "when API returns 500" do
      before do
        stub_request(:get, "https://uptime.betterstack.com/api/v2/monitors")
          .to_return(status: 500, body: { "error" => "Internal server error" }.to_json)
      end

      it "raises APIError" do
        expect { subject.get("monitors") }.to raise_error(BetterStack::APIError)
      end
    end
  end
end
