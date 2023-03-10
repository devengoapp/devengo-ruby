# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      class ThirdPartyIdentifierCollection < Base
        include Enumerable

        map :items

        def initialize(identifiers)
          identifiers_array = []

          identifiers.each do |identifier|
            case identifier[:type]
            when "iban"
              identifiers_array << ThirdPartyIdentifierIban.new(identifier)
            when "ukscan"
              identifiers_array << ThirdPartyIdentifierUkScan.new(identifier)
            end
          end

          super items: identifiers_array
        end

        def each(&block)
          @items.each(&block)
        end

        def size
          count
        end

        def empty?
          @items.empty?
        end
      end
    end
  end
end
