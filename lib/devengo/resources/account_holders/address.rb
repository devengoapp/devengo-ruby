# frozen_string_literal: true

module Devengo
  module Resources
    module AccountHolders
      class Address < Shared::Base
        map :address
        map :postal_code
        map :city
        map :province
        map :country
      end
    end
  end
end
