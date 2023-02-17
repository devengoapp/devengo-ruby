# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      class Pagination < Base
        map :self
        map :first
        map :last
        map :next
        map :prev
        map :total_items
      end
    end
  end
end
