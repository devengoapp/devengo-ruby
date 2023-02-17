# frozen_string_literal: true

module Devengo
  module Resources
    module Accounts
      class Balance < Shared::Base
        map :available
        map :total

        def initialize(**attributes)
          super(
            **attributes,
            available: Shared::Money.new(**attributes[:available]),
            total: Shared::Money.new(**attributes[:total])
          )
        end
      end
    end
  end
end
