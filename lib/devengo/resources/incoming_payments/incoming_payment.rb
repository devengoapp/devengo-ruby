# frozen_string_literal: true

module Devengo
  module Resources
    module IncomingPayments
      class IncomingPayment < Shared::BaseResponse
        map :id
        map :account_id
        map :status
        map :description
        map :amount
        map :company_reference
        map :third_party
        map :internal
        map :created_at
        map :instant
        map :processor
        map :fee

        def self.from_raw(api_response:, **attributes)
          super api_response: api_response,
                **attributes,
                amount: Shared::Money.from_raw(**attributes[:amount]),
                third_party: Shared::ThirdParties::ThirdParty.from_raw(**attributes[:third_party]),
                processor: Shared::Processor.from_raw(**attributes[:processor]),
                fee: Shared::Money.from_raw_nullable(attributes[:fee])
        end
      end
    end
  end
end
