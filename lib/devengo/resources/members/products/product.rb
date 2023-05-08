# frozen_string_literal: true

module Devengo
  module Resources
    module Members
      module Products
        class Product < Shared::Base
          map :name
          map :slug
        end
      end
    end
  end
end
