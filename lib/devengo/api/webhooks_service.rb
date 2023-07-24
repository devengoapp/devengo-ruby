# frozen_string_literal: true

module Devengo
  module API
    class WebhooksService < Service
      def find(webhook_id:, **opts)
        api_response = client.get(path: "webhooks/#{webhook_id}", **opts)
        Resources::Webhooks::Webhook.from_raw(api_response: api_response, **api_response.body[:webhook])
      end

      def list(**opts)
        api_response = client.get(path: "webhooks", **opts)
        Resources::Webhooks::Collection.from_raw(
          api_response: api_response,
          raw_collection: api_response.body[:webhooks]
        )
      end

      def create(**opts)
        api_response = client.post(path: "webhooks", **opts)
        Resources::Webhooks::Webhook.from_raw(api_response: api_response, **api_response.body[:webhook])
      end

      def update(webhook_id:, **opts)
        api_response = client.put(path: "webhooks/#{webhook_id}", **opts)
        Resources::Webhooks::Webhook.from_raw(api_response: api_response, **api_response.body[:webhook])
      end

      def delete(webhook_id:, **opts)
        client.delete(path: "webhooks/#{webhook_id}", **opts)
        nil
      end
    end
  end
end
