# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      class ThirdPartyIdentifierCollection < BaseCollection
        def initialize(identifiers)
          super items: identifiers.map { |identifier| raw_identifier_parser(identifier) }
        end

        private def raw_identifier_parser(identifier)
          case identifier[:type]
          when "iban"
            ThirdPartyIdentifierIban.new(**identifier)
          when "ukscan"
            ThirdPartyIdentifierUkScan.new(**identifier)
          end
        end
      end
    end
  end
end
