require "spec_helper"

RSpec.describe BetterStack::Configuration do
  subject { described_class.new }

  describe "#initialize" do
    it "sets default values" do
      expect(subject.base_url).to eq("https://uptime.betterstack.com/api/v2")
      expect(subject.timeout).to eq(30)
      expect(subject.retries).to eq(3)
    end
  end

  describe "#valid?" do
    context "when api_token is nil" do
      before { subject.api_token = nil }

      it "returns false" do
        expect(subject.valid?).to be false
      end
    end

    context "when api_token is empty" do
      before { subject.api_token = "" }

      it "returns false" do
        expect(subject.valid?).to be false
      end
    end

    context "when api_token is present" do
      before { subject.api_token = "test_token" }

      it "returns true" do
        expect(subject.valid?).to be true
      end
    end
  end
end
