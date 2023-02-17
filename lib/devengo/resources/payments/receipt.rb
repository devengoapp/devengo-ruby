# frozen_string_literal: true

module Devengo
  module Resources
    module Payments
      class Receipt < Shared::BaseResponse
        map :id
        map :url
      end
    end
  end
end
