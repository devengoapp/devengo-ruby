# frozen_string_literal: true

module Devengo
  module Errors
    class Client < Http
      attr_reader :code, :type, :title, :detail

      def initialize(api_response:, client_error:)
        super message: client_error[:message], api_response: api_response

        @code = client_error[:code]
        @type = client_error[:type]
        @title = client_error[:title]
        @detail = client_error[:detail]
      end
    end
  end
end
