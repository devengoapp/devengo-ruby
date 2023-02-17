# frozen_string_literal: true

module Devengo
  module HelperMethods
    def initialize_client(**opts)
      Devengo::Client.new(
        email: "email@devengo.com",
        password: "example_password",
        logger_enabled: false,
        **opts
      )
    end

    def http_fixture(*names)
      File.join(RSPEC_ROOT, "fixtures", *names)
    end

    def read_http_response_fixture(resource, fixture_name)
      file_name = ["responses", resource, "#{fixture_name}.http"].join("/")
      File.read(http_fixture(file_name))
    end

    def instance_methods_count(item)
      object_to_count_methods(item).instance_methods(false).count { |method| !(method.end_with? "=") }
    end

    private def object_to_count_methods(item)
      return item if item.is_a? Module

      item.class
    end
  end
end
