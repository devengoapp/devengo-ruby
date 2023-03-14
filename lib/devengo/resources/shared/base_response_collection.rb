# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      class BaseResponseCollection < BaseCollection
        map :raw_collection
        map :api_response
        map :pagination
        map :meta

        def self.from_raw(api_response:, raw_collection: [])
          super api_response: api_response,
                raw_collection: raw_collection,
                items: parse_raw_collection(raw_collection),
                pagination: init_pagination(api_response),
                meta: api_response.body[:meta]
        end

        private_class_method def self.parse_raw_collection(raw_collection)
          raw_collection.map do |attributes_item|
            item_klass.from_raw(api_response: nil, **attributes_item)
          end
        end

        private_class_method def self.init_pagination(api_response)
          api_response_body = api_response.body

          return if api_response_body[:links].nil?

          Pagination.from_raw_nullable(
            **api_response_body[:links],
            total_items: api_response_body.dig(:meta, :pagination, :total_items)
          )
        end

        def self.item_klass
          BaseResponse
        end
      end
    end
  end
end
