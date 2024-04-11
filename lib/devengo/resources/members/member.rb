# frozen_string_literal: true

module Devengo
  module Resources
    module Members
      class Member < Shared::BaseResponse
        map :id
        map :name
        map :email
        map :locale
        map :time_zone
        map :status
        map :job_position
        map :products
        map :referrer_id
        map :product_newsletter

        def self.from_raw(api_response:, **attributes)
          super api_response: api_response,
                **attributes,
                products: Products::Collection.from_raw_nullable(attributes[:products])
        end
      end
    end
  end
end
