# frozen_string_literal: true

module Devengo
  module Resources
    module Transactions
      class Transaction < Shared::BaseResponse
        map :id
        map :account_id
        map :description
        map :operation_date
        map :operation_type
        map :credit_debit
        map :amount
        map :balance
        map :company_reference
        map :entity
        map :third_party

        def initialize(api_response:, **attributes)
          super api_response: api_response,
                **attributes,
                third_party: Shared::ThirdParty.new(**attributes[:third_party]),
                balance: Shared::Money.new(**attributes[:balance]),
                amount: Shared::Money.new(**attributes[:amount]),
                entity: Entity.init_nullable(attributes[:entity])
        end
      end
    end
  end
end
