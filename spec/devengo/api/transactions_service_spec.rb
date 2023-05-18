# frozen_string_literal: true

RSpec.describe Devengo::API::TransactionsService, :integration, type: :api do
  subject(:transactions_service) { described_class.new(initialize_client) }

  describe "find transaction" do
    include_context "with stub request",
                    path: "accounts/acc_fYpgX5Ytdxzexuf61lFmw/transactions/txn_3NuWZw8zSY2LNMoNXgVwaR",
                    resource: "transactions/find"

    let!(:transaction) do
      transactions_service.find(account_id: "acc_fYpgX5Ytdxzexuf61lFmw", transaction_id: "txn_3NuWZw8zSY2LNMoNXgVwaR")
    end

    it_behaves_like "builds correct request",
                    method: :get,
                    path: "accounts/acc_fYpgX5Ytdxzexuf61lFmw/transactions/txn_3NuWZw8zSY2LNMoNXgVwaR"

    it "transaction with expected data" do
      expect(transaction).to be_a Devengo::Resources::Transactions::Transaction
      expect(instance_methods_count(transaction)).to eq 13
      expect(transaction.id).to eq "txn_3NuWZw8zSY2LNMoNXgVwaR"
      expect(transaction.account_id).to eq "acc_fYpgX5Ytdxzexuf61lFmw"
      expect(transaction.description).to eq "Transaction description"
      expect(transaction.operation_date).to eq "2022-01-01T12:00:10Z"
      expect(transaction.created_at).to eq "2022-01-01T12:00:00Z"
      expect(transaction.valued_at).to eq "2022-01-01T12:00:10Z"
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
      expect(transaction.third_party.account.bank).to be_a Devengo::Resources::Shared::ThirdParties::Accounts::Bank
      expect(transaction.third_party.account.bank.name).to eq "Revolut Payments UAB"
      expect(transaction.third_party.account.bank.bic).to eq "REVOLT21"
    end
  end

  describe "list transactions" do
    include_context "with stub request",
                    path: "accounts/acc_fYpgX5Ytdxzexuf61lFmw/transactions",
                    resource: "transactions/list"

    let!(:transactions) { transactions_service.list(account_id: "acc_fYpgX5Ytdxzexuf61lFmw") }

    it_behaves_like "builds correct request",
                    method: :get,
                    path: "accounts/acc_fYpgX5Ytdxzexuf61lFmw/transactions"

    it "transactions with expected data" do
      transaction1 = transactions.to_a[0]
      transaction2 = transactions.to_a[1]

      expect(transaction1).to be_a Devengo::Resources::Transactions::Transaction
      expect(instance_methods_count(transaction1)).to eq 13
      expect(transaction1.id).to eq "txn_3NuWZw8zSY2LNMoNXgVwaR"
      expect(transaction1.account_id).to eq "acc_fYpgX5Ytdxzexuf61lFmw"
      expect(transaction1.description).to eq "Transaction description"
      expect(transaction1.operation_date).to eq "2022-01-01T12:00:10Z"
      expect(transaction1.created_at).to eq "2022-01-01T12:00:00Z"
      expect(transaction1.valued_at).to eq "2022-01-01T12:00:10Z"
      expect(transaction1.operation_type).to eq "deposit"
      expect(transaction1.credit_debit).to eq "debit"
      expect(transaction1.amount).to be_a Devengo::Resources::Shared::Money
      expect(transaction1.amount.cents).to eq 100
      expect(transaction1.amount.currency).to eq "EUR"
      expect(transaction1.balance).to be_a Devengo::Resources::Shared::Money
      expect(transaction1.balance.cents).to eq 10_000
      expect(transaction1.balance.currency).to eq "EUR"
      expect(transaction1.company_reference).to eq "123"
      expect(transaction1.entity).to be_a Devengo::Resources::Transactions::Entity
      expect(transaction1.entity.id).to eq "pyo_4JgnTOvdXQWn81NK1bOhIY"
      expect(transaction1.entity.type).to eq "payment"
      expect(transaction1.entity.ref).to eq "https://api.devengo.com/v1/payments/pyo_4JgnTOvdXQWn81NK1bOhIY"
      expect(transaction1.third_party).to be_a Devengo::Resources::Shared::ThirdParties::ThirdParty
      expect(transaction1.third_party.name).to eq "Company S.L."
      expect(transaction1.third_party.account).to be_a Devengo::Resources::Shared::ThirdParties::Accounts::Account
      expect(transaction1.third_party.account.identifiers.count).to eq 1
      expect(transaction1.third_party.account.identifiers.first).to be_a Devengo::Resources::Shared::ThirdParties::Identifiers::Iban # rubocop:disable Layout/LineLength
      expect(transaction1.third_party.account.identifiers.first.type).to eq "iban"
      expect(transaction1.third_party.account.identifiers.first.iban).to eq "LT501243351241283711"
      expect(transaction1.third_party.account.bank).to be_a Devengo::Resources::Shared::ThirdParties::Accounts::Bank
      expect(transaction1.third_party.account.bank.name).to eq "Revolut Payments UAB"
      expect(transaction1.third_party.account.bank.bic).to eq "REVOLT21"

      expect(transaction2).to be_a Devengo::Resources::Transactions::Transaction
      expect(instance_methods_count(transaction2)).to eq 13
      expect(transaction2.id).to eq "txn_3NuWZw8zSY2LNMoNXgVwuK"
      expect(transaction2.account_id).to eq "acc_fYpgX5Ytdxzexuf61lFmw"
      expect(transaction2.description).to eq "Transaction description"
      expect(transaction2.operation_date).to eq "2022-01-01T12:00:10Z"
      expect(transaction2.created_at).to eq "2022-01-01T12:00:00Z"
      expect(transaction2.valued_at).to eq "2022-01-01T12:00:10Z"
      expect(transaction2.operation_type).to eq "deposit"
      expect(transaction2.credit_debit).to eq "debit"
      expect(transaction2.amount).to be_a Devengo::Resources::Shared::Money
      expect(transaction2.amount.cents).to eq 100
      expect(transaction2.amount.currency).to eq "EUR"
      expect(transaction2.balance).to be_a Devengo::Resources::Shared::Money
      expect(transaction2.balance.cents).to eq 10_000
      expect(transaction2.balance.currency).to eq "EUR"
      expect(transaction2.company_reference).to eq "123"
      expect(transaction2.entity).to be_a Devengo::Resources::Transactions::Entity
      expect(transaction2.entity.id).to eq "pyo_4JgnTOvdXQWn81NK1bOhIY"
      expect(transaction2.entity.type).to eq "payment"
      expect(transaction2.entity.ref).to eq "https://api.devengo.com/v1/payments/pyo_4JgnTOvdXQWn81NK1bOhIY"
      expect(transaction2.third_party).to be_a Devengo::Resources::Shared::ThirdParties::ThirdParty
      expect(transaction2.third_party.name).to eq "Company S.L."
      expect(transaction2.third_party.account).to be_a Devengo::Resources::Shared::ThirdParties::Accounts::Account
      expect(transaction2.third_party.account.identifiers.count).to eq 1
      expect(transaction2.third_party.account.identifiers.first).to be_a Devengo::Resources::Shared::ThirdParties::Identifiers::UkScan # rubocop:disable Layout/LineLength
      expect(transaction2.third_party.account.identifiers.first.type).to eq "ukscan"
      expect(transaction2.third_party.account.identifiers.first.sort_code).to eq "040342"
      expect(transaction2.third_party.account.identifiers.first.account_number).to eq "00631971"
      expect(transaction2.third_party.account.bank).to be_a Devengo::Resources::Shared::ThirdParties::Accounts::Bank
      expect(transaction2.third_party.account.bank.name).to eq "Revolut Payments UAB"
      expect(transaction2.third_party.account.bank.bic).to eq "REVOLT21"
    end

    it "return expected element" do
      expect(transactions).to be_a Devengo::Resources::Transactions::Collection
      expect(transactions.count).to eq 2
    end
  end
end
