# frozen_string_literal: true

RSpec.describe Devengo::API::IncomingPaymentsService, :integration, type: :api do
  subject(:incoming_payments_service) { described_class.new(initialize_client) }

  shared_examples "incoming payment expects" do
    it "incoming payment with expected data" do
      expect(incoming_payment).to be_a Devengo::Resources::IncomingPayments::IncomingPayment
      expect(instance_methods_count(incoming_payment)).to eq 12
      expect(incoming_payment.id).to eq "pyi_7FssaPM2jVvKGwoRJB1R36"
      expect(incoming_payment.account_id).to eq "acc_7SZwPFdReAtDu8aNr1T5dE"
      expect(incoming_payment.status).to eq "confirmed"
      expect(incoming_payment.description).to eq "Incoming payment description"
      expect(incoming_payment.company_reference).to eq "123"
      expect(incoming_payment.internal).to be false
      expect(incoming_payment.instant).to be true
      expect(incoming_payment.processor.network).to eq "SEPA"
      expect(incoming_payment.processor.scheme).to eq "SCT-INST"
      expect(incoming_payment.amount).to be_a Devengo::Resources::Shared::Money
      expect(incoming_payment.amount.cents).to eq 10_000
      expect(incoming_payment.amount.currency).to eq "EUR"
      expect(incoming_payment.third_party).to be_a Devengo::Resources::Shared::ThirdParties::ThirdParty
      expect(incoming_payment.third_party.name).to eq "Company S.L."
      expect(incoming_payment.third_party.account.identifiers.count).to eq 1
      expect(incoming_payment.third_party.account.identifiers.first).to be_a Devengo::Resources::Shared::ThirdParties::Identifiers::Iban # rubocop:disable Layout/LineLength
      expect(incoming_payment.third_party.account.identifiers.first.type).to eq "iban"
      expect(incoming_payment.third_party.account.identifiers.first.iban).to eq "LT501243351241283711"
      expect(incoming_payment.third_party.account.bank).to be_a Devengo::Resources::Shared::ThirdParties::Accounts::Bank
      expect(incoming_payment.third_party.account.bank.name).to eq "Revolut Payments UAB"
      expect(incoming_payment.third_party.account.bank.bic).to eq "REVOLT21"
      expect(incoming_payment.created_at).to eq "2022-01-01T12:00:00Z"
      expect(incoming_payment.fee).to be_a Devengo::Resources::Shared::Money
      expect(incoming_payment.fee.cents).to eq 10
      expect(incoming_payment.fee.currency).to eq "EUR"
    end
  end

  describe "find incoming payment" do
    include_context "with stub request",
                    path: "incoming_payments/pyi_7FssaPM2jVvKGwoRJB1R36",
                    resource: "incoming_payments/find"

    let!(:incoming_payment) { incoming_payments_service.find(incoming_payment_id: "pyi_7FssaPM2jVvKGwoRJB1R36") } # rubocop:disable RSpec/LetSetup

    it_behaves_like "builds correct request",
                    path: "incoming_payments/pyi_7FssaPM2jVvKGwoRJB1R36"

    it_behaves_like "incoming payment expects"
  end

  describe "list incoming payments" do
    include_context "with stub request",
                    path: "incoming_payments",
                    resource: "incoming_payments/list"

    let!(:incoming_payments) { incoming_payments_service.list }
    let(:incoming_payment) { incoming_payments.first }

    it_behaves_like "builds correct request",
                    path: "incoming_payments"

    it_behaves_like "incoming payment expects"

    it "return expected element" do
      expect(incoming_payments).to be_a Devengo::Resources::IncomingPayments::Collection
      expect(incoming_payments.count).to eq 1
    end
  end
end
