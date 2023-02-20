# frozen_string_literal: true

module Devengo
  module Resources
    module Members
      class Member < Shared::BaseResponse
        map :id
        map :name
        map :email
        map :locale
        map :status
        map :job_position
        map :referrer_id
      end
    end
  end
end
