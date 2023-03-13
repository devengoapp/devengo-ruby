# frozen_string_literal: true

module Devengo
  module Resources
    module Shared
      class BaseResponse < Base
        map :api_response

        def self.from_raw(api_response:, **attributes)
          super api_response: api_response, **attributes
        end
      end
    end
  end
end
