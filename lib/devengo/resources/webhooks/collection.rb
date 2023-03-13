# frozen_string_literal: true

module Devengo
  module Resources
    module Webhooks
      class Collection < Shared::BaseResponseCollection
        def self.item_klass
          Webhook
        end
      end
    end
  end
end
