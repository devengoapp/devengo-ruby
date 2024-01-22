# frozen_string_literal: true

module Devengo
  module API
    class AccountHoldersService < Service
      def find(account_holder_id:, **opts)
        api_response = client.get(path: "account_holders/#{account_holder_id}", **opts)
        Resources::AccountHolders::AccountHolder.from_raw(
          api_response: api_response,
          **api_response.body[:account_holder]
        )
      end

      def list(**opts)
        api_response = client.get(path: "account_holders", **opts)
        Resources::AccountHolders::Collection.from_raw(
          api_response: api_response,
          raw_collection: api_response.body[:account_holders]
        )
      end

      def create(**opts)
        api_response = client.post(path: "account_holders", **opts)
        Resources::AccountHolders::AccountHolder.from_raw(api_response: api_response, **api_response.body[:account_holder])
      end

      def close(account_holder_id:, **opts)
        client.patch(path: "account_holders/#{account_holder_id}/close", **opts)
        nil
      end
    end
  end
end
