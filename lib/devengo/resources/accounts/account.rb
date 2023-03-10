# frozen_string_literal: true

module Devengo
  module Resources
    module Accounts
      class Account < Shared::BaseResponse
        map :id
        map :bank
        map :status
        map :name
        map :number
        map :identifiers
        map :currency
        map :metadata
        map :balance
        map :created_at

        def initialize(api_response:, **attributes)
          super api_response: api_response,
                **attributes,
                identifiers: Shared::ThirdPartyIdentifierCollection.new(attributes[:identifiers]),
                balance: Balance.new(**attributes[:balance]),
                bank: Shared::ThirdPartyBank.init_nullable(attributes[:bank])
        end
      end
    end
  end
end
