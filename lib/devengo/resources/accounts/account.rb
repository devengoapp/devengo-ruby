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

        def initialize(api_response:, **attributes) # rubocop:disable Metrics/MethodLength
          identifiers = []

          attributes[:identifiers].each do |identifier|
            case identifier[:type]
            when "iban"
              identifiers << Shared::AccountIdentifierIban.init_nullable(identifier)
            when "ukscan"
              identifiers << Shared::AccountIdentifierUkScan.init_nullable(identifier)
            end
          end

          super api_response: api_response,
                **attributes,
                identifiers: identifiers,
                balance: Balance.new(**attributes[:balance]),
                bank: Shared::ThirdPartyBank.init_nullable(attributes[:bank])
        end
      end
    end
  end
end
