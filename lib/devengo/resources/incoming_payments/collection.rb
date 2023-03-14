# frozen_string_literal: true

module Devengo
  module Resources
    module IncomingPayments
      class Collection < Shared::BaseResponseCollection
        def self.item_klass
          IncomingPayment
        end
      end
    end
  end
end
