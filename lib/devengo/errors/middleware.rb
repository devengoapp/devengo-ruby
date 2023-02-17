# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength

module Devengo
  module Errors
    class Middleware < Faraday::Middleware
      def on_complete(env)
        @env = env

        case env.status
        when (200..300)
          nil
        when 400
          raise BadRequest, client_error_params
        when 401
          raise Unauthorized, client_error_params
        when 403
          raise Forbidden, client_error_params
        when 404
          raise NotFound, client_error_params
        when 407
          raise ProxyAuth, client_error_params
        when 409
          raise Conflict, client_error_params
        when 410
          raise Gone, client_error_params
        when 422
          raise UnprocessableEntity, client_error_params
        when 429
          raise TooManyRequests, client_error_params
        when (400...500)
          raise Client, client_error_params
        when (500...600)
          raise Server, base_error_params
        else
          raise Base, base_error_params
        end
      end

      private def client_error_params
        @env.body[:error].to_h
      end

      private def base_error_params
        @env.body[:exception] || @env.body
      end
    end
  end
end

# rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
