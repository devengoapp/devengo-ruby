# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      class ThirdParty < Shared::Base
        map :name
        map :account
        map :account_number
        map :bank

        def initialize(**attributes)
          super(
            **attributes,
            account: ThirdPartyAccount.new(attributes[:account]),
            account_number: ThirdPartyAccountNumber.init_nullable(attributes[:account_number]),
            bank: ThirdPartyBank.init_nullable(attributes[:bank])
          )
        end
      end
    end
  end
end
