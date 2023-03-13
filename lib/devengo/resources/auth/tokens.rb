# frozen_string_literal: true

module Devengo
  module Resources
    module Auth
      class Tokens < Shared::BaseResponse
        map :token, :access_token
        map :refresh_token

        def self.from_raw(api_response:, **attributes)
          super(
            api_response: api_response,
            **attributes,
            token: Token.from_raw(value: attributes[:token]),
            refresh_token: Token.from_raw(value: attributes[:refresh_token])
          )
        end
      end
    end
  end
end
