# frozen_string_literal: true

module Devengo
  module Resources
    module AccountHolders
      class Collection < Shared::BaseResponseCollection
        def self.item_klass
          AccountHolder
        end
      end
    end
  end
end
