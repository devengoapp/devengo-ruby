# frozen_string_literal: true

RSpec.describe Devengo::API::TransactionsService, :integration, type: :api do
  subject(:transactions_service) { described_class.new(initialize_client) }

  shared_examples "transaction expects" do
    it "transaction with expected data" do
      expect(transaction).to be_a Devengo::Resources::Transactions::Transaction
      expect(instance_methods_count(transaction)).to eq 11
      expect(transaction.id).to eq "txn_3NuWZw8zSY2LNMoNXgVwaR"
      expect(transaction.account_id).to eq "acc_fYpgX5Ytdxzexuf61lFmw"
      expect(transaction.description).to eq "Transaction description"
      expect(transaction.operation_date).to eq "2022-01-01T12:00:00Z"
      expect(transaction.operation_type).to eq "deposit"
      expect(transaction.credit_debit).to eq "debit"
      expect(transaction.amount).to be_a Devengo::Resources::Shared::Money
      expect(transaction.amount.cents).to eq 100
      expect(transaction.amount.currency).to eq "EUR"
      expect(transaction.balance).to be_a Devengo::Resources::Shared::Money
      expect(transaction.balance.cents).to eq 10_000
      expect(transaction.balance.currency).to eq "EUR"
      expect(transaction.company_reference).to eq "123"
      expect(transaction.entity).to be_a Devengo::Resources::Transactions::Entity
      expect(transaction.entity.id).to eq "pyo_4JgnTOvdXQWn81NK1bOhIY"
      expect(transaction.entity.type).to eq "payment"
      expect(transaction.entity.ref).to eq "https://api.devengo.com/v1/payments/pyo_4JgnTOvdXQWn81NK1bOhIY"
      expect(transaction.third_party).to be_a Devengo::Resources::Shared::ThirdParties::ThirdParty
      expect(transaction.third_party.name).to eq "Company S.L."
      expect(transaction.third_party.account).to be_a Devengo::Resources::Shared::ThirdParties::Accounts::Account
      expect(transaction.third_party.account.identifiers.count).to eq 1
      expect(transaction.third_party.account.identifiers.first).to be_a Devengo::Resources::Shared::ThirdParties::Identifiers::Iban # rubocop:disable Layout/LineLength
      expect(transaction.third_party.account.identifiers.first.type).to eq "iban"
      expect(transaction.third_party.account.identifiers.first.iban).to eq "LT501243351241283711"
      expect(transaction.third_party.account.bank).to be_a Devengo::Resources::Shared::ThirdParties::Bank
      expect(transaction.third_party.account.bank.name).to eq "Revolut Payments UAB"
      expect(transaction.third_party.account.bank.bic).to eq "REVOLT21"
    end
  end

  describe "find transaction" do
    include_context "with stub request",
                    path: "accounts/acc_fYpgX5Ytdxzexuf61lFmw/transactions/txn_3NuWZw8zSY2LNMoNXgVwaR",
                    resource: "transactions/find"

    let!(:transaction) do # rubocop:disable RSpec/LetSetup
      transactions_service.find(account_id: "acc_fYpgX5Ytdxzexuf61lFmw", transaction_id: "txn_3NuWZw8zSY2LNMoNXgVwaR")
    end

    it_behaves_like "builds correct request",
                    method: :get,
                    path: "accounts/acc_fYpgX5Ytdxzexuf61lFmw/transactions/txn_3NuWZw8zSY2LNMoNXgVwaR"

    it_behaves_like "transaction expects"
  end

  describe "list transactions" do
    include_context "with stub request",
                    path: "accounts/acc_fYpgX5Ytdxzexuf61lFmw/transactions",
                    resource: "transactions/list"

    let!(:transactions) { transactions_service.list(account_id: "acc_fYpgX5Ytdxzexuf61lFmw") }
    let(:transaction) { transactions.first }

    it_behaves_like "builds correct request",
                    method: :get,
                    path: "accounts/acc_fYpgX5Ytdxzexuf61lFmw/transactions"

    it_behaves_like "transaction expects"

    it "return expected element" do
      expect(transactions).to be_a Devengo::Resources::Transactions::Collection
      expect(transactions.count).to eq 1
    end
  end
end
