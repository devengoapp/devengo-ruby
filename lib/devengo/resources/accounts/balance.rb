# frozen_string_literal: true

module Devengo
  module Resources
    module Accounts
      class Balance < Shared::Base
        map :available
        map :total

        def self.from_raw(**attributes)
          super(
            **attributes,
            available: Shared::Money.from_raw(**attributes[:available]),
            total: Shared::Money.from_raw(**attributes[:total])
          )
        end
      end
    end
  end
end
