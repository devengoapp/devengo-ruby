# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      module ThirdParties
        module Accounts
          class Account < Shared::Base
            map :identifiers
            map :bank

            def self.from_raw(**attributes)
              super(
                **attributes,
                identifiers: ThirdParties::Identifiers::Collection.from_raw(attributes[:identifiers]),
                bank: ThirdParties::Bank.from_raw_nullable(attributes[:bank])
              )
            end
          end
        end
      end
    end
  end
end
