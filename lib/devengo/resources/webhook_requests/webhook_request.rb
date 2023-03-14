# frozen_string_literal: true

module Devengo
  module Resources
    module WebhookRequests
      class WebhookRequest < Shared::BaseResponse
        map :id
        map :url
        map :headers
        map :body
        map :created_at
        map :event_id
        map :event_name
        map :response

        def self.from_raw(api_response:, **attributes)
          super api_response: api_response, **attributes, response: Response.new(**attributes[:response])
        end
      end
    end
  end
end
