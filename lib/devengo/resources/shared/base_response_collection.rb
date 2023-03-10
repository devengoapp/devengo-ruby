# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      class BaseResponseCollection < BaseCollection
        map :api_response
        map :pagination
        map :meta

        def initialize(api_response:, item_klass:, raw_collection: [])
          super api_response: api_response,
                raw_collection: raw_collection,
                item_klass: item_klass,
                pagination: init_pagination(api_response),
                meta: api_response.body[:meta]
        end

        private def init_pagination(api_response)
          api_response_body = api_response.body

          return if api_response_body[:links].nil?

          Pagination.init_nullable(
            **api_response_body[:links],
            total_items: api_response_body.dig(:meta, :pagination, :total_items)
          )
        end
      end
    end
  end
end
