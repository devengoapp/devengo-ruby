# frozen_string_literal: true

RSpec.shared_context "with stub request" do |params|
  let(:method) { params[:method]&.to_sym || :get }
  let(:path) { params[:path] || nil }
  let(:resource) { params[:resource] || nil }
  let(:fixture_name) { params[:fixture_name] || "success" }

  before do
    stub_request(method, /#{path}/).to_return(read_http_response_fixture(resource, fixture_name))
  end
end
