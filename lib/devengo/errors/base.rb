# frozen_string_literal: true

module Devengo
  module Errors
    class Base < StandardError
      def initialize(message:)
        super message
      end
    end
  end
end

require_relative "http"

require_relative "client"

require_relative "bad_request"
require_relative "conflict"
require_relative "forbidden"
require_relative "gone"
require_relative "invalid_token"
require_relative "not_found"
require_relative "proxy_auth"
require_relative "server"
require_relative "too_many_requests"
require_relative "unauthorized"
require_relative "unprocessable_entity"
