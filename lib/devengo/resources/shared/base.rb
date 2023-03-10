# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      class Base
        def initialize(**attributes)
          attributes.each do |key, value|
            m = "#{key}=".to_sym
            send(m, value) if respond_to?(m)
          end
        end

        def self.map(original_attribute, mapped_attributes = nil)
          class_eval { attr_writer original_attribute.to_sym }
          mapped_attributes ||= original_attribute
          mapped_attributes = [mapped_attributes].flatten
          mapped_attributes.each do |mapped_attribute|
            define_method(mapped_attribute) { instance_variable_get("@#{original_attribute}") }
          end
        end

        def self.init_nullable(attributes)
          return nil if attributes.nil?

          new(**attributes)
        end
      end
    end
  end
end

require_relative "base_collection"
require_relative "base_response"
require_relative "base_response_collection"

require_relative "../accounts/account"
require_relative "../accounts/balance"
require_relative "../accounts/collection"
require_relative "../auth/token"
require_relative "../auth/tokens"
require_relative "../incoming_payments/collection"
require_relative "../incoming_payments/incoming_payment"
require_relative "../members/member"
require_relative "../payments/collection"
require_relative "../payments/destination"
require_relative "../payments/error"
require_relative "../payments/links"
require_relative "../payments/payment"
require_relative "../payments/preview"
require_relative "../payments/processor"
require_relative "../payments/receipt"
require_relative "../transactions/collection"
require_relative "../transactions/entity"
require_relative "../transactions/transaction"
require_relative "../webhook_requests/collection"
require_relative "../webhook_requests/response"
require_relative "../webhook_requests/webhook_request"
require_relative "../webhooks/collection"
require_relative "../webhooks/webhook"
require_relative "money"
require_relative "pagination"
require_relative "third_party"
require_relative "third_party_account"
require_relative "third_party_account_number"
require_relative "third_party_bank"
require_relative "third_party_identifier_iban"
require_relative "third_party_identifier_uk_scan"
