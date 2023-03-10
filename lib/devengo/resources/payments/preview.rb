# frozen_string_literal: true

module Devengo
  module Resources
    module Payments
      class Preview < Shared::BaseResponse
        map :instant
        map :eta
        map :processor

        def initialize(api_response: nil, **attributes)
          super api_response: api_response, **attributes, processor: Processor.new(**attributes[:processor])
        end
      end
    end
  end
end
