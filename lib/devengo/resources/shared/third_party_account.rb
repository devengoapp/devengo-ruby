# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      class ThirdPartyAccount < Shared::Base
        map :identifiers
        map :bank

        def initialize(**attributes) # rubocop:disable Metrics/MethodLength
          identifiers = []

          attributes[:identifiers].each do |identifier|
            case identifier[:type]
            when "iban"
              identifiers << Shared::ThirdPartyIdentifierIban.new(identifier)
            when "ukscan"
              identifiers << Shared::ThirdPartyIdentifierUkScan.new(identifier)
            end
          end

          super(
            **attributes,
            identifiers: identifiers,
            bank: ThirdPartyBank.init_nullable(attributes[:bank])
          )
        end
      end
    end
  end
end
