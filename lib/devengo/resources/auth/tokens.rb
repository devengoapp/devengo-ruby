# frozen_string_literal: true

module Devengo
  module Resources
    module Auth
      class Tokens < Shared::BaseResponse
        map :token, :access_token
        map :refresh_token

        def initialize(api_response:, **attributes)
          super(
            api_response: api_response,
            **attributes,
            token: Token.new(value: attributes[:token]),
            refresh_token: Token.new(value: attributes[:refresh_token])
          )
        end
      end
    end
  end
end
