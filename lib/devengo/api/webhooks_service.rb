# frozen_string_literal: true

module Devengo
  module API
    class WebhooksService < Service
      def find(webhook_id:, **)
        api_response = client.get(path: "webhooks/#{webhook_id}", **)
        Resources::Webhooks::Webhook.from_raw(api_response: api_response, **api_response.body[:webhook])
      end

      def list(**)
        api_response = client.get(path: "webhooks", **)
        Resources::Webhooks::Collection.from_raw(
          api_response: api_response,
          raw_collection: api_response.body[:webhooks]
        )
      end

      def create(**)
        api_response = client.post(path: "webhooks", **)
        Resources::Webhooks::Webhook.from_raw(api_response: api_response, **api_response.body[:webhook])
      end

      def update(webhook_id:, **)
        api_response = client.patch(path: "webhooks/#{webhook_id}", **)
        Resources::Webhooks::Webhook.from_raw(api_response: api_response, **api_response.body[:webhook])
      end

      def delete(webhook_id:, **)
        client.delete(path: "webhooks/#{webhook_id}", **)
        nil
      end

      def events(**)
        api_response = client.get(path: "webhooks/events", **)
        Resources::Webhooks::Events::Collection.from_raw(
          api_response: api_response,
          raw_collection: api_response.body[:events]
        )
      end
    end
  end
end
