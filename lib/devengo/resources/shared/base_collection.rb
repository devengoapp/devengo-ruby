# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      class BaseCollection < Base
        include Enumerable

        map :items

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
