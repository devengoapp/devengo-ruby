# frozen_string_literal: true

module Devengo
  module Errors
    class Http < Base
      attr_reader :api_response

      def initialize(api_response:, message:)
        super message: message

        @api_response = api_response
      end
    end
  end
end
