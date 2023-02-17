# frozen_string_literal: true

module Devengo
  module Errors
    class Client < Base
      attr_reader :code, :type

      def initialize(error_response)
        super error_response[:message]

        @code = error_response[:code]
        @type = error_response[:type]
      end
    end
  end
end
