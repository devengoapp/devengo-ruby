# frozen_string_literal: true

module Devengo
  module Resources
    module Payments
      class Payment < Shared::BaseResponse
        map :id
        map :account_id
        map :company_reference
        map :status
        map :recipient
        map :description
        map :amount
        map :destination
        map :instant
        map :eta
        map :created_at
        map :processor
        map :error
        map :links
        map :metadata

        def initialize(api_response:, **attributes)
          super api_response: api_response,
                **attributes,
                amount: Shared::Money.new(**attributes[:amount]),
                destination: Destination.new(**attributes[:destination]),
                processor: Processor.new(**attributes[:processor]),
                error: Error.init_nullable(attributes[:error]),
                links: Links.init_nullable(attributes[:links])
        end
      end
    end
  end
end
