# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      class AccountIdentifierUkScan < Shared::Base
        map :type
        map :short_code
        map :account_number
      end
    end
  end
end
