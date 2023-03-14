# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      module ThirdParties
        module Identifiers
          class Collection < BaseCollection
            def self.from_raw(identifiers)
              super items: identifiers.map { |identifier| raw_identifier_parser(identifier) }
            end

            private_class_method def self.raw_identifier_parser(identifier)
              case identifier[:type]
              when "iban"
                ThirdParties::Identifiers::Iban.from_raw(**identifier)
              when "ukscan"
                ThirdParties::Identifiers::UkScan.from_raw(**identifier)
              end
            end
          end
        end
      end
    end
  end
end
