# frozen_string_literal: true

module Devengo
  module API
    class AccountsService < Service
      def find(account_id:, **)
        api_response = client.get(path: "accounts/#{account_id}", **)
        Resources::Accounts::Account.from_raw(api_response: api_response, **api_response.body[:account])
      end

      def list(**)
        api_response = client.get(path: "accounts", **)
        Resources::Accounts::Collection.from_raw(
          api_response: api_response,
          raw_collection: api_response.body[:accounts]
        )
      end

      def create(**)
        api_response = client.post(path: "accounts", **)
        Resources::Accounts::Account.from_raw(api_response: api_response, **api_response.body[:account])
      end

      def update(account_id:, **)
        api_response = client.patch(path: "accounts/#{account_id}", **)
        Resources::Accounts::Account.from_raw(api_response: api_response, **api_response.body[:account])
      end

      def close(account_id:, **)
        client.patch(path: "accounts/#{account_id}/close", **)
        nil
      end
    end
  end
end
