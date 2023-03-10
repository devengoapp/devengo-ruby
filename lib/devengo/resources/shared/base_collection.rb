# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      class BaseCollection < Base
        include Enumerable

        map :raw_collection
        map :items

        def initialize(item_klass:, raw_collection: [], **attributes)
          super raw_collection: raw_collection,
                items: parse_raw_collection(raw_collection, item_klass),
                **attributes
        end

        private def parse_raw_collection(raw_collection, item_klass)
          raw_collection.map do |attributes_item|
            item_klass.new(**attributes_item)
          end
        end

        def each(&block)
          @items.each(&block)
        end

        def size
          count
        end

        def empty?
          @items.empty?
        end
      end
    end
  end
end
