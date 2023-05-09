# frozen_string_literal: true

module Devengo
  module API
    class VerificationsService < Service
      def find(verification_id:, **opts)
        api_response = client.get(path: "verifications/#{verification_id}", **opts)
        Resources::Verifications::Verification.from_raw(api_response: api_response, **api_response.body[:verification])
      end

      def list(**opts)
        api_response = client.get(path: "verifications", **opts)
        Resources::Verifications::Collection.from_raw(
          api_response: api_response,
          raw_collection: api_response.body[:verifications]
        )
      end
    end
  end
end
