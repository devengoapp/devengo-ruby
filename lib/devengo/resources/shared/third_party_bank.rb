# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      class ThirdPartyBank < Shared::Base
        map :bic
        map :name
      end
    end
  end
end
