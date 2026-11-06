# frozen_string_literal: true

module Devengo
  module API
    class AccountHoldersService < Service
      def find(account_holder_id:, **)
        api_response = client.get(path: "account_holders/#{account_holder_id}", **)
        Resources::AccountHolders::AccountHolder.from_raw(
          api_response: api_response,
          **api_response.body[:account_holder]
        )
      end

      def list(**)
        api_response = client.get(path: "account_holders", **)
        Resources::AccountHolders::Collection.from_raw(
          api_response: api_response,
          raw_collection: api_response.body[:account_holders]
        )
      end

      def create(**)
        api_response = client.post(path: "account_holders", **)
        Resources::AccountHolders::AccountHolder.from_raw(
          api_response: api_response,
          **api_response.body[:account_holder]
        )
      end

      def archive(account_holder_id:, **)
        client.patch(path: "account_holders/#{account_holder_id}/archive", **)
        nil
      end
    end
  end
end
