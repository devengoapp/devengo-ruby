# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      class ThirdPartyIdentifierIban < Shared::Base
        map :type
        map :iban
      end
    end
  end
end
