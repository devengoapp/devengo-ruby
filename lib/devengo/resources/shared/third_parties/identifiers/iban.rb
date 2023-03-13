# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      module ThirdParties
        module Identifiers
          class Iban < Shared::Base
            map :type
            map :iban
          end
        end
      end
    end
  end
end
