# frozen_string_literal: true

module Devengo
  module Resources
    module Verifications
      class Verification < Shared::BaseResponse
        map :id
        map :third_party
        map :status
        map :company_reference
        map :attempts
        map :eta
        map :expired_at
        map :created_at
        map :error
        map :fee
        map :metadata

        def self.from_raw(api_response:, **attributes)
          super api_response: api_response,
                **attributes,
                third_party: Shared::ThirdParties::ThirdParty.from_raw(**attributes[:third_party]),
                error: Shared::Error.from_raw_nullable(attributes[:error]),
                fee: Shared::Money.from_raw_nullable(attributes[:fee])
        end
      end
    end
  end
end
