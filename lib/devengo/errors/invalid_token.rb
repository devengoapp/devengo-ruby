# frozen_string_literal: true

module Devengo
  module Errors
    class InvalidToken < Base
      def initialize
        super message: "Invalid provided token"
      end
    end
  end
end
