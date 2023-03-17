# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      module ThirdParties
        class ThirdParty < Shared::Base
          map :name
          map :account

          def self.from_raw(**attributes)
            super(
              **attributes,
              account: Accounts::Account.from_raw_nullable(attributes[:account]),
            )
          end
        end
      end
    end
  end
end
