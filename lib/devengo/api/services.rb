# frozen_string_literal: true

module Devengo
  module API
    module Services
      def auth
        @services[:authentication] ||= AuthService.new(self)
      end

      def accounts
        @services[:accounts] ||= AccountsService.new(self)
      end

      def incoming_payments
        @services[:incoming_payments] ||= IncomingPaymentsService.new(self)
      end

      def payments
        @services[:payments] ||= PaymentsService.new(self)
      end

      def transactions
        @services[:transactions] ||= TransactionsService.new(self)
      end

      def verifications
        @services[:verifications] ||= VerificationsService.new(self)
      end

      def webhooks
        @services[:webhooks] ||= WebhooksService.new(self)
      end

      def webhook_requests
        @services[:webhook_requests] ||= WebhookRequestsService.new(self)
      end
    end
  end
end

require_relative "service"

require_relative "accounts_service"
require_relative "auth_service"
require_relative "incoming_payments_service"
require_relative "payments_service"
require_relative "transactions_service"
require_relative "verifications_service"
require_relative "webhook_requests_service"
require_relative "webhooks_service"
