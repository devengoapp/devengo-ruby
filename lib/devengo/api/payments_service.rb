# frozen_string_literal: true

module Devengo
  module API
    class PaymentsService < Service
      def find(payment_id:, **opts)
        api_response = client.get(path: "payments/#{payment_id}", **opts)
        Resources::Payments::Payment.from_raw(api_response: api_response, **api_response.body[:payment])
      end

      def list(**opts)
        api_response = client.get(path: "payments", **opts)
        Resources::Payments::Collection.from_raw(
          api_response: api_response,
          raw_collection: api_response.body[:payments]
        )
      end

      def create(**opts)
        api_response = client.post(path: "payments", **opts)
        Resources::Payments::Payment.from_raw(api_response: api_response, **api_response.body[:payment])
      end

      def preview(**opts)
        api_response = client.post(path: "payments/preview", **opts)
        Resources::Payments::Preview.from_raw(api_response: api_response, **api_response.body[:payment])
      end

      def receipt(payment_id:, **opts)
        api_response = client.get(path: "payments/#{payment_id}/receipt", **opts)
        Resources::Payments::Receipt.from_raw(api_response: api_response, **api_response.body[:receipt])
      end
    end
  end
end
