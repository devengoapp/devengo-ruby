# frozen_string_literal: true

module Devengo
  module Resources
    module WebhookRequests
      class Response < Shared::Base
        map :id
        map :headers
        map :body
        map :status
        map :created_at
        map :event_id
        map :event_name
        map :error
      end
    end
  end
end
