# frozen_string_literal: true

module Devengo
  module Resources
    module Accounts
      class Account < Shared::BaseResponse
        map :id
        map :status
        map :name
        map :number
        map :bic
        map :currency
        map :metadata
        map :balance

        def initialize(api_response:, **attributes)
          super api_response: api_response, **attributes, balance: Balance.new(**attributes[:balance])
        end
      end
    end
  end
end
