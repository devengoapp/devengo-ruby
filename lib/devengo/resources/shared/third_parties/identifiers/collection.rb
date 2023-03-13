# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      module ThirdParties
        module Identifiers
          class Collection < BaseCollection
            def initialize(identifiers)
              super items: identifiers.map { |identifier| raw_identifier_parser(identifier) }
            end

            private def raw_identifier_parser(identifier)
              case identifier[:type]
              when "iban"
                ThirdParties::Identifiers::Iban.new(**identifier)
              when "ukscan"
                ThirdParties::Identifiers::UkScan.new(**identifier)
              end
            end
          end
        end
      end
    end
  end
end
