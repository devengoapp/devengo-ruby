# frozen_string_literal: true

module Devengo
  module Resources
    module AccountHolders
      class AccountHolder < Shared::BaseResponse
        map :id
        map :commercial_name
        map :legal_name
        map :taxid
        map :status
        map :created_at
        map :closed_at
        map :company_reference
        map :slug
        map :curreny
        map :metadata

        def self.from_raw(api_response:, **attributes)
          super api_response: api_response, **attributes
        end
      end
    end
  end
end
