# frozen_string_literal: true

RSpec.describe Devengo::API::WebhooksService, :integration, type: :api do
  subject(:webhooks_service) { described_class.new(initialize_client) }

  shared_examples "webhook expects" do |parameters|
    it "webhooks with expected data" do
      expect(webhook).to be_a Devengo::Resources::Webhooks::Webhook
      expect(instance_methods_count(webhook)).to eq 6
      expect(webhook.id).to eq "whk_QMuQ74NPggjlPWOYbkLdc"
      expect(webhook.status).to eq "enabled"
      expect(webhook.url).to eq parameters[:url]
      expect(webhook.description).to be_nil
      expect(webhook.listened_events).to eq parameters[:listened_events]
      expect(webhook.secret).to eq parameters[:secret]
    end
  end

  describe "find webhook" do
    include_context "with stub request",
                    path: "webhooks/whk_QMuQ74NPggjlPWOYbkLdc",
                    resource: "webhooks/find"

    let!(:webhook) { webhooks_service.find(webhook_id: "whk_QMuQ74NPggjlPWOYbkLdc") } # rubocop:disable RSpec/LetSetup

    it_behaves_like "builds correct request",
                    path: "webhooks/whk_QMuQ74NPggjlPWOYbkLdc"

    it_behaves_like "webhook expects",
                    listened_events: %w[outgoing_payment.created outgoing_payment.confirmed],
                    url: "https://devengo.com"
  end

  describe "list webhooks" do
    include_context "with stub request",
                    path: "webhooks",
                    resource: "webhooks/list"

    let!(:webhooks) { webhooks_service.list }
    let(:webhook) { webhooks.first }

    it_behaves_like "builds correct request",
                    path: "webhooks"

    it_behaves_like "webhook expects",
                    listened_events: %w[outgoing_payment.created outgoing_payment.confirmed],
                    url: "https://devengo.com"

    it "return expected element" do
      expect(webhooks).to be_a Devengo::Resources::Webhooks::Collection
      expect(webhooks.count).to eq 1
    end
  end

  describe "update webhook" do
    include_context "with stub request",
                    method: :patch,
                    path: "webhooks/whk_QMuQ74NPggjlPWOYbkLdc",
                    resource: "webhooks/update"

    let!(:webhook) do # rubocop:disable RSpec/LetSetup
      webhooks_service.update(
        webhook_id: "whk_QMuQ74NPggjlPWOYbkLdc",
        url: "https://devengo.com/updated",
        status: "enabled",
        listened_events: %w[outgoing_payment.created outgoing_payment.confirmed]
      )
    end

    it_behaves_like "builds correct request",
                    method: :patch,
                    path: "webhooks/whk_QMuQ74NPggjlPWOYbkLdc",
                    body: {
                      url: "https://devengo.com/updated",
                      status: "enabled",
                      listened_events: %w[outgoing_payment.created outgoing_payment.confirmed],
                    }

    it_behaves_like "webhook expects",
                    status: "enabled",
                    listened_events: %w[outgoing_payment.created outgoing_payment.confirmed],
                    url: "https://devengo.com/updated"
  end

  describe "delete webhook" do
    include_context "with stub request",
                    method: :delete,
                    path: "webhooks/whk_QMuQ74NPggjlPWOYbkLdc",
                    resource: "webhooks/delete"

    let!(:response) { webhooks_service.delete(webhook_id: "whk_QMuQ74NPggjlPWOYbkLdc") }

    it_behaves_like "builds correct request",
                    method: :delete,
                    path: "webhooks/whk_QMuQ74NPggjlPWOYbkLdc"

    it "return nil" do
      expect(response).to be_nil
    end
  end

  describe "webhook events" do
    include_context "with stub request",
                    method: :get,
                    path: "webhooks/events",
                    resource: "webhooks/events"

    let!(:response) { webhooks_service.events }

    it_behaves_like "builds correct request",
                    method: :get,
                    path: "webhooks/events"

    it "return expected element" do
      expect(response).to be_a Devengo::Resources::Webhooks::Events::Collection
      expect(response.count).to eq 3
      expect(response.items).to eq %w[outgoing_payment.created outgoing_payment.processing outgoing_payment.confirmed]
    end
  end
end
