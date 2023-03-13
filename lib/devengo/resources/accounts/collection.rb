# frozen_string_literal: true

module Devengo
  module Resources
    module Accounts
      class Collection < Shared::BaseResponseCollection
        def self.item_klass
          Account
        end
      end
    end
  end
end
