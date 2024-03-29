# frozen_string_literal: true

RSpec.describe Devengo::API::VerificationsService, :integration, type: :api do
  subject(:verifications_services) { described_class.new(initialize_client) }

  shared_examples "verification expects" do
    it "verification with expected data" do
      expect(verification).to be_a Devengo::Resources::Verifications::Verification
      expect(instance_methods_count(verification)).to eq 11
      expect(verification.id).to eq "vrf_4krc1kE2lQL7nE7yT4wBHH"
      expect(verification.status).to eq "error"
      expect(verification.company_reference).to be_nil
      expect(verification.attempts).to eq 0
      expect(verification.eta).to eq "2023-05-04T09:52:50Z"
      expect(verification.created_at).to eq "2023-05-04T09:52:46Z"
      expect(verification.expired_at).to eq "2023-05-11T09:52:46Z"
      expect(verification.third_party).to be_a Devengo::Resources::Shared::ThirdParties::ThirdParty
      expect(verification.third_party.name).to eq "Ana Devenger"
      expect(verification.third_party.account.identifiers.count).to eq 1
      expect(verification.third_party.account.identifiers.first).to be_a Devengo::Resources::Shared::ThirdParties::Identifiers::Iban # rubocop:disable Layout/LineLength
      expect(verification.third_party.account.identifiers.first.type).to eq "iban"
      expect(verification.third_party.account.identifiers.first.iban).to eq "ES2420803225768994261966"
      expect(verification.third_party.account.bank).to be_a Devengo::Resources::Shared::ThirdParties::Accounts::Bank
      expect(verification.third_party.account.bank.name).to eq "Abanca Corporación Bancaria, S.A."
      expect(verification.third_party.account.bank.bic).to eq "CAGLESMMXXX"
      expect(verification.error.code).to eq "ERR-0001"
      expect(verification.error.type).to eq "blocked_account"
      expect(verification.error.reason).to eq "AC06"
      expect(verification.metadata).to eq example_key: "example_value"
      expect(verification.fee).to be_a Devengo::Resources::Shared::Money
      expect(verification.fee.cents).to eq 10
      expect(verification.fee.currency).to eq "EUR"
    end
  end

  describe "find verification" do
    include_context "with stub request",
                    method: :get,
                    path: "verifications/vrf_4krc1kE2lQL7nE7yT4wBHH",
                    resource: "verifications/find"

    let!(:verification) { verifications_services.find(verification_id: "vrf_4krc1kE2lQL7nE7yT4wBHH") } # rubocop:disable RSpec/LetSetup

    it_behaves_like "builds correct request",
                    method: :get,
                    path: "verifications/vrf_4krc1kE2lQL7nE7yT4wBHH"

    it_behaves_like "verification expects"
  end

  describe "list verifications" do
    include_context "with stub request",
                    method: :get,
                    path: "verifications",
                    resource: "verifications/list"

    let!(:verifications) { verifications_services.list }
    let(:verification) { verifications.first }

    it_behaves_like "builds correct request",
                    method: :get,
                    path: "verifications"

    it_behaves_like "verification expects"

    it "return expected element" do
      expect(verifications).to be_a Devengo::Resources::Verifications::Collection
      expect(verifications.count).to eq 1
    end
  end

  describe "create verification" do
    include_context "with stub request",
                    method: :post,
                    path: "verifications",
                    resource: "verifications/create"

    let!(:verification) do # rubocop:disable RSpec/LetSetup
      verifications_services.create(destination: { iban: "ES2420803225768994261966" }, recipient: "Ana Devenger")
    end

    it_behaves_like "builds correct request",
                    method: :post,
                    path: "verifications"

    it_behaves_like "verification expects"
  end

  describe "confirm verifications" do
    include_context "with stub request",
                    method: :post,
                    path: "verifications/vrf_4krc1kE2lQL7nE7yT4wBHH/confirm",
                    resource: "verifications/confirm"

    let!(:verification) do
      verifications_services.confirm(verification_id: "vrf_4krc1kE2lQL7nE7yT4wBHH", code: "56778")
    end

    it_behaves_like "builds correct request",
                    method: :post,
                    path: "verifications/vrf_4krc1kE2lQL7nE7yT4wBHH/confirm"

    it "return nil" do
      expect(verification).to be_nil
    end
  end
end
