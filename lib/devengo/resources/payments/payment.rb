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
        map :internal
        map :eta
        map :created_at
        map :processor
        map :error
        map :links
        map :third_party
        map :metadata

        def initialize(api_response: nil, **attributes)
          super api_response: api_response,
                **attributes,
                amount: Shared::Money.new(**attributes[:amount]),
                destination: Destination.new(**attributes[:destination]),
                processor: Processor.new(**attributes[:processor]),
                error: Error.init_nullable(attributes[:error]),
                third_party: Shared::ThirdParty.new(**attributes[:third_party]),
                links: Links.init_nullable(attributes[:links])
        end
      end
    end
  end
end
