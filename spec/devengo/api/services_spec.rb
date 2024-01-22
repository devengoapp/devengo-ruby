# frozen_string_literal: true

RSpec.describe Devengo::API::Services, :unit, type: :api do
  let!(:client) { initialize_client }

  it "includes all expected services" do
    expect(instance_methods_count(described_class)).to eq 9
    expect(client.accounts).to be_an_instance_of(Devengo::API::AccountsService)
    expect(client.incoming_payments).to be_an_instance_of(Devengo::API::IncomingPaymentsService)
    expect(client.auth).to be_an_instance_of(Devengo::API::AuthService)
    expect(client.payments).to be_an_instance_of(Devengo::API::PaymentsService)
    expect(client.transactions).to be_an_instance_of(Devengo::API::TransactionsService)
    expect(client.webhooks).to be_an_instance_of(Devengo::API::WebhooksService)
    expect(client.webhook_requests).to be_an_instance_of(Devengo::API::WebhookRequestsService)
    expect(client.verifications).to be_an_instance_of(Devengo::API::VerificationsService)
  end
end
