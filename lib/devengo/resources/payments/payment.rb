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
        map :retried
        map :eta
        map :created_at
        map :processor
        map :error
        map :links
        map :third_party
        map :metadata

        def self.from_raw(api_response:, **attributes)
          super api_response: api_response,
                **attributes,
                amount: Shared::Money.from_raw(**attributes[:amount]),
                destination: Destination.from_raw(**attributes[:destination]),
                processor: Shared::Processor.from_raw(**attributes[:processor]),
                error: Shared::Error.from_raw_nullable(attributes[:error]),
                third_party: Shared::ThirdParties::ThirdParty.from_raw(**attributes[:third_party]),
                links: Links.from_raw_nullable(attributes[:links])
        end
      end
    end
  end
end
