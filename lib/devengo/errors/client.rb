# frozen_string_literal: true

module Devengo
  module Errors
    class Client < Http
      attr_reader :code, :type

      def initialize(api_response:, client_error:)
        super message: client_error[:message], api_response: api_response

        @code = client_error[:code]
        @type = client_error[:type]
      end
    end
  end
end
