# frozen_string_literal: true

module Devengo
  module Resources
    module Payments
      class Error < Shared::Base
        map :code
        map :type
        map :reason
      end
    end
  end
end
