# frozen_string_literal: true

module Devengo
  module Resources
    module Payments
      class Preview < Shared::BaseResponse
        map :instant
        map :eta
        map :processor

        def self.from_raw(api_response:, **attributes)
          super api_response: api_response, **attributes, processor: Processor.from_raw(**attributes[:processor])
        end
      end
    end
  end
end
