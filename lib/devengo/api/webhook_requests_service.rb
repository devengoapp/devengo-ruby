# frozen_string_literal: true

module Devengo
  module API
    class WebhookRequestsService < Service
      def find(webhook_id:, webhook_request_id:, **opts)
        api_response = client.get(path: "webhooks/#{webhook_id}/requests/#{webhook_request_id}", **opts)
        Resources::WebhookRequests::WebhookRequest.from_raw(api_response: api_response, **api_response.body[:request])
      end

      def list(webhook_id:, **opts)
        api_response = client.get(path: "webhooks/#{webhook_id}/requests", **opts)
        Resources::WebhookRequests::Collection.from_raw(
          api_response: api_response,
          raw_collection: api_response.body[:requests]
        )
      end
    end
  end
end
