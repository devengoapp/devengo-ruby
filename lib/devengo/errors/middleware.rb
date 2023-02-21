# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength

module Devengo
  module Errors
    class Middleware < Faraday::Middleware
      def on_complete(env)
        @env = env

        case env.status
        when (200..399)
          nil
        when 400
          raise BadRequest.new(**client_error_params)
        when 401
          raise Unauthorized.new(**client_error_params)
        when 403
          raise Forbidden.new(**client_error_params)
        when 404
          raise NotFound.new(**client_error_params)
        when 407
          raise ProxyAuth.new(**client_error_params)
        when 409
          raise Conflict.new(**client_error_params)
        when 410
          raise Gone.new(**client_error_params)
        when 422
          raise UnprocessableEntity.new(**client_error_params)
        when 429
          raise TooManyRequests.new(**client_error_params)
        when (400..499)
          raise Client.new(**client_error_params)
        when (500..599)
          raise Server.new(**http_error_params)
        else
          raise Http.new(**http_error_params)
        end
      end

      private def client_error_params
        { api_response: @env.response, client_error: @env.body[:error].to_h }
      end

      private def http_error_params
        { api_response: @env.response, message: @env.body[:exception] || @env.body }
      end
    end
  end
end

# rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
