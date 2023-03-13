# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      module ThirdParties
        module Accounts
          class Account < Shared::Base
            map :identifiers
            map :bank

            def initialize(**attributes)
              super(
                **attributes,
                identifiers: ThirdParties::Identifiers::Collection.new(attributes[:identifiers]),
                bank: ThirdParties::Bank.init_nullable(attributes[:bank])
              )
            end
          end
        end
      end
    end
  end
end
