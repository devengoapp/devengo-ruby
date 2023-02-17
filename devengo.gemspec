# frozen_string_literal: true

require_relative "lib/devengo/version"

Gem::Specification.new do |spec|
  spec.name    = "devengo-api"
  spec.version = Devengo::VERSION
  spec.authors = ["Ignacio Ortiz Cobo"]
  spec.email   = ["nacho@devengo.com"]

  spec.summary               = "Ruby client for Devengo Finance API."
  spec.description           = "Ruby client for Devengo Finance API."
  spec.required_ruby_version = ">= 2.7.0"

  spec.license = "MIT"

  spec.homepage = "https://devengo.com/"
  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "source_code_uri" => "https://github.com/devengoapp/devengo-ruby",
    "rubygems_mfa_required" => "true",
  }

  spec.extra_rdoc_files = Dir["README.md", "LICENSE.txt"]
  spec.files            = Dir["lib/**/*"]
  spec.require_paths    = ["lib"]

  spec.add_dependency "faraday", "~> 2.7"
  spec.add_dependency "jwt", "~> 2.7"
end
