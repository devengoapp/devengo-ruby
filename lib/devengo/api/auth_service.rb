# frozen_string_literal: true

module Devengo
  module API
    class AuthService < Service
      def login(email:, password:, **opts)
        api_response = client.post(path: "auth/tokens", authenticate: false, email: email, password: password, **opts)
        Resources::Auth::Tokens.from_raw(api_response: api_response, **api_response.body)
      end

      def me(**opts)
        api_response = client.get(path: "auth/me", **opts)
        Resources::Members::Member.from_raw(api_response: api_response, **api_response.body[:manager])
      end
    end
  end
end
