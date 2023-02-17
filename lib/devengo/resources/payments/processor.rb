# frozen_string_literal: true

module Devengo
  module Resources
    module Payments
      class Processor < Shared::Base
        map :network
        map :scheme
      end
    end
  end
end
