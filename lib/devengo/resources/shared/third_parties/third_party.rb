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

          def self.from_raw(**attributes)
            super(
              **attributes,
              account: Accounts::Account.from_raw_nullable(attributes[:account]),
              account_number: Accounts::AccountNumber.from_raw_nullable(attributes[:account_number]),
              bank: Bank.from_raw_nullable(attributes[:bank])
            )
          end
        end
      end
    end
  end
end
