# frozen_string_literal: true

module Devengo
  module Resources
    module Members
      module Products
        class Collection < Shared::BaseCollection
          def self.from_raw(products)
            super items: products.map { |product| Product.from_raw(**product) }
          end

          def self.from_raw_nullable(attributes)
            return nil if attributes.nil?

            from_raw(attributes)
          end
        end
      end
    end
  end
end
