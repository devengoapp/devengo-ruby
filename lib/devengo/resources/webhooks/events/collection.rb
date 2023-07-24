# frozen_string_literal: true

module Devengo
  module Resources
    module Webhooks
      module Events
        class Collection < Devengo::Resources::Shared::BaseCollection
          map :raw_collection
          map :api_response

          def self.from_raw(api_response:, raw_collection: [])
            super api_response: api_response,
                  raw_collection: raw_collection,
                  items: raw_collection
          end
        end
      end
    end
  end
end
