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

    let!(:member) { auth_service.me }

    it_behaves_like "builds correct request",
                    path: "auth/me"

    it "member with expected data" do
      expect(member).to be_a Devengo::Resources::Members::Member
      expect(instance_methods_count(member)).to eq 9
      expect(member.id).to eq "man_5MjSD4kLS3TszL0kbwPjPN"
      expect(member.name).to eq "Ana"
      expect(member.locale).to eq "es"
      expect(member.time_zone).to eq "Etc/UTC"
      expect(member.email).to eq "ana@devengo.com"
      expect(member.job_position).to eq "product"
      expect(member.status).to eq "active"
      expect(member.products).to be_a Devengo::Resources::Members::Products::Collection
      expect(member.products.count).to eq 1
      expect(member.products.first).to be_a Devengo::Resources::Members::Products::Product
      expect(member.products.first.slug).to eq "payments"
      expect(member.products.first.name).to eq "Payments"
    end
  end
end
