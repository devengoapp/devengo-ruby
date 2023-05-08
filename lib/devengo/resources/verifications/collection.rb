# frozen_string_literal: true

module Devengo
  module Resources
    module Verifications
      class Collection < Shared::BaseResponseCollection
        def self.item_klass
          Verification
        end
      end
    end
  end
end
