# frozen_string_literal: true

module Devengo
  module Resources
    module Webhooks
      class Webhook < Shared::BaseResponse
        map :id
        map :status
        map :url
        map :description
        map :listened_events
        map :secret

        def self.from_raw(api_response:, **attributes)
          super api_response: api_response, **attributes, secret: attributes[:secret]
        end
      end
    end
  end
end
