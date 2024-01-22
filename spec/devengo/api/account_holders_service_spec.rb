# frozen_string_literal: true

RSpec.describe Devengo::API::AccountHoldersService, :integration, type: :api do
  subject(:account_holders_service) { described_class.new(initialize_client) }

  shared_examples "account holders expects" do |parameters|
    it "account holder with expected data" do
      expect(account_holder).to be_a Devengo::Resources::AccountHolders::AccountHolder
      expect(instance_methods_count(account_holder)).to eq 11
      expect(account_holder.id).to eq "ach_5hAMRnqljBGXuvhfz0uRip"
      expect(account_holder.status).to eq "created"
      expect(account_holder.commercial_name).to eq "My account holder"
      expect(account_holder.legal_name).to eq "My account holder SL"
      expect(account_holder.currency).to eq "EUR"
      expect(account_holder.metadata).to eq parameters[:metadata]
      expect(account_holder.created_at).to eq "2023-01-01T12:00:00Z"
      expect(account_holder.closed_at).to be_nil
    end
  end

  describe "find account holder" do
    include_context "with stub request",
                    path: "account_holders/ach_5hAMRnqljBGXuvhfz0uRip",
                    resource: "account_holders/find"

    let!(:account_holder) { account_holders_service.find(account_holder_id: "ach_5hAMRnqljBGXuvhfz0uRip") } # rubocop:disable RSpec/LetSetup

    it_behaves_like "builds correct request",
                    path: "account_holders/ach_5hAMRnqljBGXuvhfz0uRip"

    it_behaves_like "account holders expects",
                    metadata: { example_key: "example_value" }
  end

  describe "list account holders" do
    include_context "with stub request",
                    path: "account_holders",
                    resource: "account_holders/list"

    let!(:account_holders) { account_holders_service.list }
    let(:account_holder) { account_holders.first }

    it_behaves_like "builds correct request",
                    path: "account_holders"

    it_behaves_like "account holders expects",
                    metadata: { example_key: "example_value" }

    it "return expected element" do
      expect(account_holders).to be_a Devengo::Resources::AccountHolders::Collection
      expect(account_holders.count).to eq 2
    end
  end

  describe "create account holder" do
    include_context "with stub request",
                    method: :post,
                    path: "account_holders",
                    resource: "account_holders/create"

    let!(:account_holder) do # rubocop:disable RSpec/LetSetup
      account_holders_service.create(
        commercial_name: "My new account holder",
        legal_name: "My new account holder SL",
        currency: "EUR",
        metadata: { example_key: "example_value" }
      )
    end

    it_behaves_like "builds correct request",
                    method: :post,
                    path: "account_holder",
                    body: {
                      commercial_name: "My new account holder",
                      legal_name: "My new account holder SL",
                      currency: "EUR",
                      metadata: { example_key: "example_value" },
                    }

    it_behaves_like "account holders expects",
                    metadata: { example_key: "example_value" }
  end

  describe "close account holder" do
    include_context "with stub request",
                    method: :patch,
                    path: "account_holders/ach_5hAMRnqljBGXuvhfz0uRip/close",
                    resource: "account_holders/close"

    let!(:response) { account_holders_service.close(account_holder_id: "ach_5hAMRnqljBGXuvhfz0uRip") }

    it_behaves_like "builds correct request",
                    method: :patch,
                    path: "account_holders/ach_5hAMRnqljBGXuvhfz0uRip/close"

    it "return nil" do
      expect(response).to be_nil
    end
  end
end
