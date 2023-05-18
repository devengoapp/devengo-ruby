# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      class Error < Base
        map :code
        map :type
        map :reason
      end
    end
  end
end
