# frozen_string_literal: true

RSpec.describe Devengo::Client do
  describe "default logger" do
    let(:password) { "p@ss\"w!rd" }
    let(:jwt) { JWT.encode({ exp: Time.now.to_i + 3600 }, nil, "none") }
    let(:json_headers) { { "Content-Type" => "application/json" } }

    def leaking_nothing(*secrets)
      satisfy("leak none of the secrets") { |log| secrets.none? { |secret| log.include?(secret) } }
    end

    it "keeps the password and the returned tokens out of the log" do
      stub_request(:post, %r{/auth/tokens})
        .to_return(status: 201, body: { token: jwt, refresh_token: jwt }.to_json, headers: json_headers)
      client = described_class.new(email: "user@example.com", password: password)

      expect { client.auth.login(email: "user@example.com", password: password) }.to output(
        a_string_including('"password":[FILTERED]', '"token":[FILTERED]', '"refresh_token":[FILTERED]')
          .and(leaking_nothing("p@ss", jwt))
      ).to_stdout
    end

    it "keeps the bearer token out of the log" do
      stub_request(:get, %r{/accounts}).to_return(status: 200, body: "{}", headers: json_headers)
      client = described_class.new(token: jwt)

      expect { client.get(path: "accounts") }.to output(
        a_string_including("Authorization: [FILTERED]").and(leaking_nothing(jwt))
      ).to_stdout
    end
  end
end
