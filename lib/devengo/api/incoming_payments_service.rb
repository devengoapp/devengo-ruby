# frozen_string_literal: true

module Devengo
  module API
    class IncomingPaymentsService < Service
      def find(incoming_payment_id:, **opts)
        api_response = client.get(path: "incoming_payments/#{incoming_payment_id}", **opts)
        Resources::IncomingPayments::IncomingPayment.from_raw(
          api_response: api_response,
          **api_response.body[:incoming_payment]
        )
      end

      def list(**opts)
        api_response = client.get(path: "incoming_payments", **opts)
        Resources::IncomingPayments::Collection.from_raw(
          api_response: api_response,
          raw_collection: api_response.body[:incoming_payments]
        )
      end
    end
  end
end
