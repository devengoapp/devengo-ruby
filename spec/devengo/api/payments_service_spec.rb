# frozen_string_literal: true

RSpec.describe Devengo::API::PaymentsService, :integration, type: :api do
  subject(:payments_services) { described_class.new(initialize_client) }

  shared_examples "payment expects" do
    it "payment with expected data" do
      expect(payment).to be_a Devengo::Resources::Payments::Payment
      expect(instance_methods_count(payment)).to eq 17
      expect(payment.id).to eq "pyo_4JgnTOvdXQWn81NK1bOhIY"
      expect(payment.status).to eq "confirmed"
      expect(payment.recipient).to eq "Ana Devenguer"
      expect(payment.company_reference).to eq "123"
      expect(payment.description).to eq "March payout"
      expect(payment.amount).to be_a Devengo::Resources::Shared::Money
      expect(payment.amount.currency).to eq "EUR"
      expect(payment.amount.cents).to eq 12_200
      expect(payment.destination).to be_a Devengo::Resources::Payments::Destination
      expect(payment.destination.iban).to eq "ES4131908294777999369566"
      expect(payment.account_id).to eq "acc_7SZwPFdReAtDu8aNr1T5dE"
      expect(payment.instant).to be false
      expect(payment.internal).to be false
      expect(payment.eta).to eq "2023-02-09T11:14:17Z"
      expect(payment.created_at).to eq "2023-02-09T11:14:07Z"
      expect(payment.processor).to be_a Devengo::Resources::Payments::Processor
      expect(payment.processor.network).to eq "SEPA"
      expect(payment.processor.scheme).to eq "SCT-INST"
      expect(payment.error).to be_nil
      expect(payment.links).to be_a Devengo::Resources::Payments::Links
      expect(payment.links.receipt).to eq "https://api.sandbox.devengo.com/v1/payments/pyo_4JgnTOvdXQWn81NK1bOhIY/receipt/download"
      expect(payment.third_party).to be_a Devengo::Resources::Shared::ThirdParty
      expect(payment.third_party.name).to eq "Ana Devenguer"
      expect(payment.third_party.account_number).to be_a Devengo::Resources::Shared::ThirdPartyAccountNumber
      expect(payment.third_party.account_number.iban).to eq "ES4131908294777999369566"
      expect(payment.third_party.bank).to be_a Devengo::Resources::Shared::ThirdPartyBank
      expect(payment.third_party.bank.name).to eq "Banco de Sabadell, S.A."
      expect(payment.third_party.bank.bic).to eq "BSABESBBXXX"
      expect(payment.metadata).to eq example_key: "example_value"
    end
  end

  describe "find payment" do
    include_context "with stub request",
                    method: :get,
                    path: "payments/pyo_4JgnTOvdXQWn81NK1bOhIY",
                    resource: "payments/find"

    let!(:payment) { payments_services.find(payment_id: "pyo_4JgnTOvdXQWn81NK1bOhIY") } # rubocop:disable RSpec/LetSetup

    it_behaves_like "builds correct request",
                    method: :get,
                    path: "payments/pyo_4JgnTOvdXQWn81NK1bOhIY"

    it_behaves_like "payment expects"
  end

  describe "list payments" do
    include_context "with stub request",
                    method: :get,
                    path: "payments",
                    resource: "payments/list"

    let!(:payments) { payments_services.list }
    let(:payment) { payments.first }

    it_behaves_like "builds correct request",
                    method: :get,
                    path: "payments"

    it_behaves_like "payment expects"

    it "return expected element" do
      expect(payments).to be_a Devengo::Resources::Payments::Collection
      expect(payments.count).to eq 1
    end
  end

  describe "create payment" do
    include_context "with stub request",
                    method: :post,
                    path: "payments",
                    resource: "payments/create"

    let!(:payment) do # rubocop:disable RSpec/LetSetup
      payments_services.create(
        destination: "ES1300818894222454568159",
        amount: { cents: 12_200, currency: "EUR" },
        metadata: { example_key: "example_value" },
        account_id: "acc_fYpgX5Ytdxzexuf61lFmw",
        company_reference: "123",
        recipient: "Ana Devenguer",
        description: "March payout"
      )
    end

    it_behaves_like "builds correct request",
                    method: :post,
                    path: "payments",
                    body: {
                      destination: "ES1300818894222454568159",
                      amount: { cents: 12_200, currency: "EUR" },
                      metadata: { example_key: "example_value" },
                      account_id: "acc_fYpgX5Ytdxzexuf61lFmw",
                      company_reference: "123",
                      recipient: "Ana Devenguer",
                      description: "March payout",
                    }

    it_behaves_like "payment expects"
  end

  describe "preview payment" do
    include_context "with stub request",
                    method: :post,
                    path: "payments/preview",
                    resource: "payments/preview"

    let!(:preview) do
      payments_services.preview(
        destination: "ES1300818894222454568159",
        amount: { cents: 12_200, currency: "EUR" },
        metadata: { example_key: "example_value" },
        account_id: "acc_fYpgX5Ytdxzexuf61lFmw",
        company_reference: "123",
        recipient: "Ana Devenguer",
        description: "March payout"
      )
    end

    it_behaves_like "builds correct request",
                    method: :post,
                    path: "payments/preview",
                    body: {
                      destination: "ES1300818894222454568159",
                      amount: { cents: 12_200, currency: "EUR" },
                      metadata: { example_key: "example_value" },
                      account_id: "acc_fYpgX5Ytdxzexuf61lFmw",
                      company_reference: "123",
                      recipient: "Ana Devenguer",
                      description: "March payout",
                    }

    it "preview with expected data" do
      expect(preview).to be_a Devengo::Resources::Payments::Preview
      expect(instance_methods_count(preview)).to eq 3
      expect(preview.instant).to be true
      expect(preview.processor).to be_a Devengo::Resources::Payments::Processor
      expect(preview.eta).to eq "2023-02-09T11:14:17Z"
      expect(preview.processor.network).to eq "SEPA"
      expect(preview.processor.scheme).to eq "SCT-INST"
    end
  end

  describe "receipt payment" do
    include_context "with stub request",
                    method: :get,
                    path: "payments/pyo_4JgnTOvdXQWn81NK1bOhIY/receipt",
                    resource: "payments/receipt"

    let!(:receipt) { payments_services.receipt(payment_id: "pyo_4JgnTOvdXQWn81NK1bOhIY") }

    it_behaves_like "builds correct request",
                    method: :get,
                    path: "payments/pyo_4JgnTOvdXQWn81NK1bOhIY/receipt"

    it "receipt with expected data" do
      expect(receipt).to be_a Devengo::Resources::Payments::Receipt
      expect(instance_methods_count(receipt)).to eq 2
      expect(receipt.id).to eq "pyo_4JgnTOvdXQWn81NK1bOhIY"
      expect(receipt.url).to eq "https://api.sandbox.devengo.com/v1/payments/pyo_4JgnTOvdXQWn81NK1bOhIY/receipt/download"
    end
  end
end
