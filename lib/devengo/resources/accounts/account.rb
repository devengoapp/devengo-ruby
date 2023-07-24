# frozen_string_literal: true

module Devengo
  module Resources
    module Accounts
      class Account < Shared::BaseResponse
        map :id
        map :bank
        map :status
        map :name
        map :identifiers
        map :currency
        map :metadata
        map :balance
        map :created_at
        map :closed_at

        def self.from_raw(api_response:, **attributes)
          super api_response: api_response,
                **attributes,
                identifiers: Shared::ThirdParties::Identifiers::Collection.from_raw(attributes[:identifiers]),
                balance: Balance.from_raw(**attributes[:balance]),
                bank: Shared::ThirdParties::Accounts::Bank.from_raw_nullable(attributes[:bank])
        end
      end
    end
  end
end
