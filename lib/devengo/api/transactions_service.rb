# frozen_string_literal: true

module Devengo
  module API
    class TransactionsService < Service
      def find(account_id:, transaction_id:, **opts)
        api_response = client.get(path: "accounts/#{account_id}/transactions/#{transaction_id}", **opts)
        Resources::Transactions::Transaction.new(api_response: api_response, **api_response.body[:transaction])
      end

      def list(account_id:, **opts)
        api_response = client.get(path: "accounts/#{account_id}/transactions", **opts)
        Resources::Transactions::Collection.new(
          api_response: api_response,
          raw_collection: api_response.body[:transactions]
        )
      end
    end
  end
end
