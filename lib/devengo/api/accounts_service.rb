# frozen_string_literal: true

module Devengo
  module API
    class AccountsService < Service
      def find(account_id:, **opts)
        api_response = client.get(path: "accounts/#{account_id}", **opts)
        Resources::Accounts::Account.new(api_response: api_response, **api_response.body[:account])
      end

      def list(**opts)
        api_response = client.get(path: "accounts", **opts)
        Resources::Accounts::Collection.new(api_response: api_response, raw_collection: api_response.body[:accounts])
      end

      def create(**opts)
        api_response = client.post(path: "accounts", **opts)
        Resources::Accounts::Account.new(api_response: api_response, **api_response.body[:account])
      end

      def close(account_id:, **opts)
        client.patch(path: "accounts/#{account_id}/close", **opts)
        nil
      end
    end
  end
end
