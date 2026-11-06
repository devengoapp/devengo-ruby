# frozen_string_literal: true

module Devengo
  module API
    class VerificationsService < Service
      def find(verification_id:, **)
        api_response = client.get(path: "verifications/#{verification_id}", **)
        Resources::Verifications::Verification.from_raw(api_response: api_response, **api_response.body[:verification])
      end

      def list(**)
        api_response = client.get(path: "verifications", **)
        Resources::Verifications::Collection.from_raw(
          api_response: api_response,
          raw_collection: api_response.body[:verifications]
        )
      end

      def create(**)
        api_response = client.post(path: "verifications", **)
        Resources::Verifications::Verification.from_raw(api_response: api_response, **api_response.body[:verification])
      end

      def confirm(verification_id:, **)
        client.post(path: "verifications/#{verification_id}/confirm", **)
        nil
      end
    end
  end
end
