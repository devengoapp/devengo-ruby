# frozen_string_literal: true

module Devengo
  module Resources
    module Transactions
      class Collection < Shared::BaseResponseCollection
        def self.item_klass
          Transaction
        end
      end
    end
  end
end
