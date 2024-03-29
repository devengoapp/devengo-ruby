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
        api_response = client.patch(path: "webhooks/#{webhook_id}", **opts)
        Resources::Webhooks::Webhook.from_raw(api_response: api_response, **api_response.body[:webhook])
      end

      def delete(webhook_id:, **opts)
        client.delete(path: "webhooks/#{webhook_id}", **opts)
        nil
      end

      def events(**opts)
        api_response = client.get(path: "webhooks/events", **opts)
        Resources::Webhooks::Events::Collection.from_raw(
          api_response: api_response,
          raw_collection: api_response.body[:events]
        )
      end
    end
  end
end
