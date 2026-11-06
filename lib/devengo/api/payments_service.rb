# frozen_string_literal: true

module Devengo
  module API
    class PaymentsService < Service
      def find(payment_id:, **)
        api_response = client.get(path: "payments/#{payment_id}", **)
        Resources::Payments::Payment.from_raw(api_response: api_response, **api_response.body[:payment])
      end

      def list(**)
        api_response = client.get(path: "payments", **)
        Resources::Payments::Collection.from_raw(
          api_response: api_response,
          raw_collection: api_response.body[:payments]
        )
      end

      def create(**)
        api_response = client.post(path: "payments", **)
        Resources::Payments::Payment.from_raw(api_response: api_response, **api_response.body[:payment])
      end

      def preview(**)
        api_response = client.post(path: "payments/preview", **)
        Resources::Payments::Preview.from_raw(api_response: api_response, **api_response.body[:payment])
      end

      def receipt(payment_id:, **)
        api_response = client.get(path: "payments/#{payment_id}/receipt", **)
        Resources::Payments::Receipt.from_raw(api_response: api_response, **api_response.body[:receipt])
      end
    end
  end
end
