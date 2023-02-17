# frozen_string_literal: true

module Devengo
  module Resources
    module Transactions
      class Entity < Shared::Base
        map :id
        map :type
        map :ref
      end
    end
  end
end
