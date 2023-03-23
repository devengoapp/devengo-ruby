# frozen_string_literal: true

require "faraday"

require_relative "api/services"
require_relative "errors/base"
require_relative "errors/middleware"
require_relative "resources/shared/base"

module Devengo
  class Client
    include Devengo::API::Services

    SANDBOX_URL = "https://api.sandbox.devengo.com/v1"
    private_constant :SANDBOX_URL

    def initialize(**options)
      @base_url = options[:base_url] || SANDBOX_URL
      @origin = options[:origin] || default_origin
      @proxy = options[:proxy]
      @token = init_token(options[:token])
      @email = options[:email] || ENV.fetch("DEVENGO_USER", nil)
      @password = options[:password] || ENV.fetch("DEVENGO_PASSWORD", nil)
      @logger_enabled = options[:logger_enabled].nil? ? true : options[:logger_enabled]
      @services = {}
    end

    def delete(path:, authenticate: true, **opts)
      request method: :delete, path: path, authenticate: authenticate, opts: opts
    end

    def get(path:, authenticate: true, **opts)
      request method: :get, path: path, authenticate: authenticate, opts: opts
    end

    def patch(path:, authenticate: true, **opts)
      request method: :patch, path: path, authenticate: authenticate, opts: opts
    end

    def post(path:, authenticate: true, **opts)
      request method: :post, path: path, authenticate: authenticate, opts: opts
    end

    def put(path:, authenticate: true, **opts)
      request method: :put, path: path, authenticate: authenticate, opts: opts
    end

    private def request(method:, path:, authenticate:, opts:)
      connection.send(method, path, parse_opts(method, opts), auth_header(authenticate))
    end

    private def connection
      @connection ||= Faraday.new(url: @base_url, headers: default_headers) { |builder| build_connection(builder) }
    end

    private def build_connection(builder)
      builder.use Errors::Middleware
      builder.response :json, content_type: /\bjson$/, preserve_raw: true, parser_options: { symbolize_names: true }
      builder.proxy = @proxy if @proxy
      if @logger_enabled
        builder.response :logger, nil, { headers: true, bodies: true } do |logger|
          logger.filter(/("password":)"(\w+)"/, '\1[FILTERED]')
        end
      end
      builder.adapter :net_http
    end

    private def parse_opts(method, opts)
      return opts.to_json if %i[post put patch].include? method

      opts
    end

    private def default_headers
      { content_type: "application/json" }
    end

    private def auth_header(authenticate)
      { authorization: "Bearer #{auth_token}" } if authenticate
    end

    private def auth_token
      login! if @token.nil? || @token.expired?

      @token.value
    end

    private def login!
      @token = auth.login(email: @email, password: @password).access_token
    end

    private def init_token(token)
      return nil if token.nil?

      Resources::Auth::Token.from_raw(value: token)
    end

    private def default_origin
      "Devengo/#{Devengo::VERSION} Ruby Client (Faraday/#{Faraday::VERSION})"
    end
  end
end
