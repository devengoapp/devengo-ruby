# frozen_string_literal: true

module Devengo
  module Resources
    module Auth
      class Me < Shared::BaseResponse
        map :id
        map :name
        map :email
        map :locale
        map :status
        map :job_position
      end
    end
  end
end
