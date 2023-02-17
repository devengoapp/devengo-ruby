# frozen_string_literal: true

module Devengo
  module Resources
    module Webhooks
      class Collection < Shared::BaseResponseCollection
        def initialize(api_response:, raw_collection:)
          super api_response: api_response, item_klass: Webhook, raw_collection: raw_collection
        end
      end
    end
  end
end
