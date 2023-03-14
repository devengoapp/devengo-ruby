# frozen_string_literal: true

require "jwt"
require "time"

module Devengo
  module Resources
    module Auth
      class Token < Shared::Base
        map :value
        map :expires_at

        def self.from_raw(**attributes)
          super(**attributes, expires_at: expires_at_by_token(attributes[:value]))
        end

        private_class_method def self.expires_at_by_token(token)
          expired_at_timestamp = JWT.decode(token, nil, false).first["exp"]

          raise Errors::InvalidToken if expired_at_timestamp.nil?

          Time.at(expired_at_timestamp.to_i).utc.iso8601
        rescue StandardError
          raise Errors::InvalidToken
        end

        def expired?
          Time.now >= Time.iso8601(expires_at)
        end
      end
    end
  end
end
