# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      module ThirdParties
        class ThirdParty < Shared::Base
          map :name
          map :account
          map :account_number
          map :bank

          def initialize(**attributes)
            super(
              **attributes,
              account: Accounts::Account.init_nullable(**attributes[:account]),
              account_number: Accounts::AccountNumber.init_nullable(attributes[:account_number]),
              bank: Bank.init_nullable(attributes[:bank])
            )
          end
        end
      end
    end
  end
end
