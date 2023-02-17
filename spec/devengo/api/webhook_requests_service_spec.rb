# frozen_string_literal: true

RSpec.describe Devengo::API::WebhookRequestsService, :integration, type: :api do
  subject(:webhook_requests_service) { described_class.new(initialize_client) }

  shared_examples "webhook request expects" do
    it "incoming payment with expected data" do
      expect(webhook_request).to be_a Devengo::Resources::WebhookRequests::WebhookRequest
      expect(instance_methods_count(webhook_request)).to eq 8
      expect(webhook_request.id).to eq "whq_4nH9nUlR87Dw5ql1OCT7EY"
      expect(webhook_request.url).to eq "https://devengo.com"
      expect(webhook_request.headers).to be_empty
      expect(webhook_request.body).to be_nil
      expect(webhook_request.created_at).to eq "2022-01-01T12:00:00Z"
      expect(webhook_request.event_id).to eq "evt_6DdZqWUAIJL8p6i44jsZWd"
      expect(webhook_request.event_name).to eq "webhook.created"
      expect(webhook_request.response).to be_a Devengo::Resources::WebhookRequests::Response
      expect(instance_methods_count(webhook_request.response)).to eq 7
      expect(webhook_request.response.id).to eq "whs_2T5vIZ5LL5jab4V3UbKyKM"
      expect(webhook_request.response.status).to eq 200
      expect(webhook_request.response.headers).to be_empty
      expect(webhook_request.response.body).to be_nil
      expect(webhook_request.response.created_at).to eq "2022-01-01T12:00:00Z"
      expect(webhook_request.response.event_id).to eq "evt_6DdZqWUAIJL8p6i44jsZWd"
      expect(webhook_request.response.event_name).to eq "webhook.created"
    end
  end

  describe "find incoming payment" do
    include_context "with stub request",
                    path: "webhooks/whk_QMuQ74NPggjlPWOYbkLdc/requests/whq_4nH9nUlR87Dw5ql1OCT7EY",
                    resource: "webhook_requests/find"

    let!(:webhook_request) do # rubocop:disable RSpec/LetSetup
      webhook_requests_service.find(
        webhook_id: "whk_QMuQ74NPggjlPWOYbkLdc",
        webhook_request_id: "whq_4nH9nUlR87Dw5ql1OCT7EY"
      )
    end

    it_behaves_like "builds correct request",
                    path: "webhooks/whk_QMuQ74NPggjlPWOYbkLdc/requests/whq_4nH9nUlR87Dw5ql1OCT7EY"

    it_behaves_like "webhook request expects"
  end

  describe "list webhook requests" do
    include_context "with stub request",
                    path: "webhooks/whk_QMuQ74NPggjlPWOYbkLdc/requests",
                    resource: "webhook_requests/list"

    let!(:webhook_requests) { webhook_requests_service.list(webhook_id: "whk_QMuQ74NPggjlPWOYbkLdc") }
    let(:webhook_request) { webhook_requests.first }

    it_behaves_like "builds correct request",
                    path: "webhooks/whk_QMuQ74NPggjlPWOYbkLdc/requests"

    it_behaves_like "webhook request expects"

    it "return expected element" do
      expect(webhook_requests).to be_a Devengo::Resources::WebhookRequests::Collection
      expect(webhook_requests.count).to eq 1
    end
  end
end
