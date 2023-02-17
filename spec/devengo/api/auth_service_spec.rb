# frozen_string_literal: true

RSpec.describe Devengo::API::AuthService, :integration, type: :api do
  subject(:auth_service) { described_class.new(initialize_client) }

  describe "login" do
    include_context "with stub request",
                    method: :post,
                    path: "auth/token",
                    resource: "auth/login"

    let!(:tokens) { auth_service.login(email: "email@devengo.com", password: "example_password") }

    it_behaves_like "builds correct request",
                    method: :post,
                    path: "auth/token",
                    headers: { "Content-Type" => "application/json" }

    it "token with expected data", authenticate: false do
      expect(tokens).to be_a Devengo::Resources::Auth::Tokens
      expect(instance_methods_count(tokens)).to eq 2
      expect(tokens.access_token).to be_a Devengo::Resources::Auth::Token
      expect(tokens.access_token.value).to eq "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoibWFuXzdQMkhhUGFjNms4R1g1T3J6eDA2MEYiLCJ1c2VyX3R5cGUiOiJNYW5hZ2VyIiwiY29tcGFueV9pZCI6bnVsbCwiZXhwIjoiMTY3NjA3NDkyMyJ9.TYzGzbjKUZAZ5JsTYB2MAgbRB0aJ5Xkyk7Pp43nehlI" # rubocop:disable Layout/LineLength
      expect(tokens.access_token).to be_expired
      expect(tokens.access_token.expires_at).to eq "2023-02-11T00:22:03Z"
      expect(tokens.refresh_token).to be_a Devengo::Resources::Auth::Token
      expect(tokens.refresh_token.value).to eq "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoibWFuXzdQMkhhUGFjNms4R1g1T3J6eDA2MEYiLCJ1c2VyX3R5cGUiOiJFbXBsb3llZSIsInJlZnJlc2hfdG9rZW5faWQiOiJyZWZfM0J0WnRNcnJQYVdIZmViT2RzZGwxTyIsImV4cCI6IjE2NzYwNzQ5MjMifQ.IBteopKZINV4gBjtwPkTC946jW6PdX5QYmGt7e3oww0" # rubocop:disable Layout/LineLength
      expect(tokens.refresh_token).to be_expired
      expect(tokens.refresh_token.expires_at).to eq "2023-02-11T00:22:03Z"
    end
  end

  describe "me" do
    include_context "with stub request",
                    path: "auth/me",
                    resource: "auth/me"

    let!(:me) { auth_service.me }

    it_behaves_like "builds correct request",
                    path: "auth/me"

    it "me with expected data" do
      expect(me).to be_a Devengo::Resources::Auth::Me
      expect(instance_methods_count(me)).to eq 6
      expect(me.id).to eq "man_5MjSD4kLS3TszL0kbwPjPN"
      expect(me.name).to eq "Ana"
      expect(me.locale).to eq "es"
      expect(me.email).to eq "satya@microsoft.com"
      expect(me.job_position).to eq "product"
      expect(me.status).to eq "active"
    end
  end
end
