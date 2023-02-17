# frozen_string_literal: true

RSpec.shared_examples "builds correct request" do |params|
  let(:default_headers) do
    {
      "Authorization" => "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoibWFuXzdQMkhhUGFjNms4R1g1T3J6eDA2MEYiLCJ1c2VyX3R5cGUiOiJNYW5hZ2VyIiwiY29tcGFueV9pZCI6bnVsbCwiZXhwIjoiMTY3NjA3NDkyMyJ9.TYzGzbjKUZAZ5JsTYB2MAgbRB0aJ5Xkyk7Pp43nehlI", # rubocop:disable Layout/LineLength
      "Content-Type" => "application/json",
    }
  end
  let(:method) { params[:method]&.to_sym || :get }
  let(:path) { params[:path] || nil }
  let(:headers) { params[:headers] || default_headers }
  let(:body) { params[:body] || {} }
  let(:query) { params[:query] || nil }

  it "builds correct request" do
    expect(WebMock).to have_requested(method, /#{path}/).with(headers: headers, body: body, query: query)
  end
end
