# frozen_string_literal: true

module Devengo
  module Resources
    module WebhookRequests
      class Collection < Shared::BaseResponseCollection
        def self.item_klass
          WebhookRequest
        end
      end
    end
  end
end
