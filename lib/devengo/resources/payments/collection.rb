# frozen_string_literal: true

module Devengo
  module Resources
    module Payments
      class Collection < Shared::BaseResponseCollection
        def self.item_klass
          Payment
        end
      end
    end
  end
end
