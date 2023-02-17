# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      class ThirdParty < Shared::Base
        map :name
        map :account_number
        map :bank

        def initialize(**attributes)
          super(
            **attributes,
            account_number: ThirdPartyAccountNumber.new(**attributes[:account_number]),
            bank: ThirdPartyBank.new(**attributes[:bank])
          )
        end
      end
    end
  end
end
