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
        map :created_at

        def initialize(api_response:, **attributes)
          super api_response: api_response,
                **attributes,
                amount: Shared::Money.new(**attributes[:amount]),
                third_party: Shared::ThirdParty.new(**attributes[:third_party])
        end
      end
    end
  end
end
