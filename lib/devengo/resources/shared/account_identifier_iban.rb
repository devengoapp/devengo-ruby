# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      class AccountIdentifierIban < Shared::Base
        map :type
        map :iban
      end
    end
  end
end
