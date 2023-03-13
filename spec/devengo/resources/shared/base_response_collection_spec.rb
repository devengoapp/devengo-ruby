# frozen_string_literal: true

RSpec.describe Devengo::Resources::Shared::BaseResponseCollection, :unit, type: :resource do
  subject(:base_response_collection) do
    described_class.new(
      api_response: api_response,
      item_klass: Devengo::Resources::Shared::BaseResponse,
      raw_collection: api_response.body[:collection]
    )
  end

  include_context "with stub request",
                  path: "collection",
                  resource: "collection"

  let(:api_response) { initialize_client.get(path: "collection", authenticate: false) }

  it "collection with expected data" do
    expect(base_response_collection.api_response).to be_a Faraday::Response
    expect(base_response_collection.count).to be 2
    expect(base_response_collection.first.api_response).to be_nil
    expect(base_response_collection.pagination).to be_a Devengo::Resources::Shared::Pagination
    expect(instance_methods_count(base_response_collection.pagination)).to be 6
    expect(base_response_collection.pagination.self).to eq "https://api.sandbox.devengo.com/v1/collection?page=1&page_size=100"
    expect(base_response_collection.pagination.first).to eq "https://api.sandbox.devengo.com/v1/collection?page=1&page_size=100"
    expect(base_response_collection.pagination.last).to eq "https://api.sandbox.devengo.com/v1/collection?page=1&page_size=100"
    expect(base_response_collection.pagination.next).to be_nil
    expect(base_response_collection.pagination.prev).to be_nil
    expect(base_response_collection.pagination.total_items).to be 2
  end

  context "without links in response" do
    include_context "with stub request",
                    path: "collection",
                    resource: "collection",
                    fixture_name: "without_links_success"

    it "collection with expected data" do
      expect(base_response_collection.pagination).to be_nil
    end
  end
end
