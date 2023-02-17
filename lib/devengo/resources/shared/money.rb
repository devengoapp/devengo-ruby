# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      class Money < Base
        map :cents
        map :currency
      end
    end
  end
end
