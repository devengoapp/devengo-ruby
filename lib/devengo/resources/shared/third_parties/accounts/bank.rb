# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      module ThirdParties
        module Accounts
          class Bank < Shared::Base
            map :bic
            map :name
          end
        end
      end
    end
  end
end
