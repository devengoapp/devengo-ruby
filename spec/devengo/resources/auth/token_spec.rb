# frozen_string_literal: true

RSpec.describe Devengo::Resources::Auth::Token, :unit, type: :resource do
  subject(:token) do
    described_class.from_raw(value: "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoibWFuXzdQMkhhUGFjNms4R1g1T3J6eDA2MEYiLCJ1c2VyX3R5cGUiOiJNYW5hZ2VyIiwiY29tcGFueV9pZCI6bnVsbCwiZXhwIjoiMTY3NjA3NDkyMyJ9.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx") # rubocop:disable Layout/LineLength
  end

  it "token with expected expires_at" do
    expect(token.expires_at).to eq "2023-02-11T00:22:03Z"
  end

  describe "expired?" do
    it "not expired token" do
      Timecop.freeze(Time.iso8601("2023-02-11T00:22:02Z")) do
        expect(token).not_to be_expired
      end
    end

    it "expired token" do
      Timecop.freeze(Time.iso8601("2023-02-11T00:22:03Z")) do
        expect(token).to be_expired
      end
    end
  end

  context "when token is invalid" do
    [
      ["eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoibWFuXzdQMkhhUGFjNms4R1g1T3J6eDA2MEYiLCJ1c2VyX3R5cGUiOiJNYW5hZ2VyIiwiY29tcGFueV9pZCI6bnVsbCwiZXhwIjoiaW52YWxpZF9leHAifQ.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"], # rubocop:disable Layout/LineLength
      ["invalid_token"],
    ].each do |invalid_token|
      it "raise an expected exception" do
        expect { described_class.from_raw(value: invalid_token) }.to raise_error do |exception|
          expect(exception).to be_a Devengo::Errors::InvalidToken
          expect(exception.message).to eq "Invalid provided token"
        end
      end
    end
  end
end
