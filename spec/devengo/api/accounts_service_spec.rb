# frozen_string_literal: true

RSpec.describe Devengo::API::AccountsService, :integration, type: :api do
  subject(:accounts_service) { described_class.new(initialize_client) }

  shared_examples "accounts expects" do |parameters|
    it "account with expected data" do
      expect(account).to be_a Devengo::Resources::Accounts::Account
      expect(instance_methods_count(account)).to eq 9
      expect(account.id).to eq "acc_7SZwPFdReAtDu8aNr1T5dE"
      expect(account.status).to eq "created"
      expect(account.name).to eq "My account"
      expect(account.number).to eq parameters[:account_number]
      expect(account.currency).to eq "EUR"
      expect(account.bank).to be_a parameters[:bank]
      expect(account.balance).to be_a Devengo::Resources::Accounts::Balance
      expect(account.balance.available).to be_a Devengo::Resources::Shared::Money
      expect(account.balance.available.cents).to eq parameters[:available_cents]
      expect(account.balance.available.currency).to eq "EUR"
      expect(account.balance.total).to be_a Devengo::Resources::Shared::Money
      expect(account.balance.total.cents).to eq parameters[:total_cents]
      expect(account.balance.total.currency).to eq "EUR"
      expect(account.metadata).to eq parameters[:metadata]
      expect(account.created_at).to eq "2023-01-01T12:00:00Z"
    end

    it "account bank with expected data", if: parameters[:bank] != NilClass do
      expect(account.bank.bic).to eq "PFSSESM1XXX"
      expect(account.bank.name).to eq "Prepaid Financial Services Limited, S.E"
    end
  end

  describe "find account" do
    include_context "with stub request",
                    path: "accounts/acc_7SZwPFdReAtDu8aNr1T5dE",
                    resource: "accounts/find"

    let!(:account) { accounts_service.find(account_id: "acc_7SZwPFdReAtDu8aNr1T5dE") } # rubocop:disable RSpec/LetSetup

    it_behaves_like "builds correct request",
                    path: "accounts/acc_7SZwPFdReAtDu8aNr1T5dE"

    it_behaves_like "accounts expects",
                    account_number: "ES8967130002000000025500",
                    available_cents: 10_000,
                    total_cents: 11_000,
                    bank: Devengo::Resources::Shared::ThirdPartyBank,
                    metadata: { example_key: "example_value" }
  end

  describe "list accounts" do
    include_context "with stub request",
                    path: "accounts",
                    resource: "accounts/list"

    let!(:accounts) { accounts_service.list }
    let(:account) { accounts.first }

    it_behaves_like "builds correct request",
                    path: "accounts"

    it_behaves_like "accounts expects",
                    account_number: "ES8967130002000000025500",
                    available_cents: 10_000,
                    total_cents: 11_000,
                    bank: Devengo::Resources::Shared::ThirdPartyBank,
                    metadata: { example_key: "example_value" }

    it "return expected element" do
      expect(accounts).to be_a Devengo::Resources::Accounts::Collection
      expect(accounts.count).to eq 1
    end
  end

  describe "create account" do
    include_context "with stub request",
                    method: :post,
                    path: "accounts",
                    resource: "accounts/create"

    let!(:account) do # rubocop:disable RSpec/LetSetup
      accounts_service.create(name: "My new account", currency: "EUR", metadata: { example_key: "example_value" })
    end

    it_behaves_like "builds correct request",
                    method: :post,
                    path: "accounts",
                    body: { name: "My new account", currency: "EUR", metadata: { example_key: "example_value" } }

    it_behaves_like "accounts expects",
                    account_number: nil,
                    available_cents: 0,
                    total_cents: 0,
                    bank: nil.class,
                    metadata: {}
  end

  describe "close account" do
    include_context "with stub request",
                    method: :patch,
                    path: "accounts/acc_7SZwPFdReAtDu8aNr1T5dE/close",
                    resource: "accounts/close"

    let!(:response) { accounts_service.close(account_id: "acc_7SZwPFdReAtDu8aNr1T5dE") }

    it_behaves_like "builds correct request",
                    method: :patch,
                    path: "accounts/acc_7SZwPFdReAtDu8aNr1T5dE/close"

    it "return nil" do
      expect(response).to be_nil
    end
  end
end
