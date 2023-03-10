# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      class ThirdPartyAccount < Shared::Base
        map :identifiers
        map :bank

        def initialize(**attributes)
          super(
            **attributes,
            identifiers: ThirdPartyIdentifierCollection.new(attributes[:identifiers]),
            bank: ThirdPartyBank.init_nullable(attributes[:bank])
          )
        end
      end
    end
  end
end
