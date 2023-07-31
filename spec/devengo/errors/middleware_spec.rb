# frozen_string_literal: true

RSpec.describe Devengo::Errors::Middleware, :unit, type: :error do
  subject(:middleware) { described_class.new({}) }

  let(:env) { double }
  let(:api_response) { double }
  let(:body) do
    {
      error: { message: "Resource not found", code: "account_not_found", type: "not_found_error" },
      exception: "Sample message",
    }
  end

  before do
    allow(env).to receive_messages(response: api_response, status: status, body: body)
  end

  context "when is a client HTTP code" do
    [
      [400, Devengo::Errors::BadRequest],
      [401, Devengo::Errors::Unauthorized],
      [403, Devengo::Errors::Forbidden],
      [404, Devengo::Errors::NotFound],
      [407, Devengo::Errors::ProxyAuth],
      [409, Devengo::Errors::Conflict],
      [410, Devengo::Errors::Gone],
      [422, Devengo::Errors::UnprocessableEntity],
      [429, Devengo::Errors::TooManyRequests],
      [(Array(400..499) - [400, 401, 403, 404, 407, 409, 410, 422, 429]).sample, Devengo::Errors::Client],
    ].each do |status, exception_expected|
      describe status.to_s do
        let(:status) { status }

        it "raise #{exception_expected} with expected data" do
          expect { middleware.send(:on_complete, env) }.to raise_error do |exception_raised|
            expect(exception_raised).to be_a exception_expected
            expect(exception_raised.message).to eq "Resource not found"
            expect(exception_raised.code).to eq "account_not_found"
            expect(exception_raised.type).to eq "not_found_error"
          end
        end
      end
    end
  end

  context "when is server error HTTP code" do
    [
      [rand(500..599), Devengo::Errors::Server],
      [nil, Devengo::Errors::Http],
    ].each do |status, exception_expected|
      describe status.to_s do
        let(:status) { status }

        it "raise exception with expected data" do
          expect { middleware.send(:on_complete, env) }.to raise_error do |exception_raised|
            expect(exception_raised).to be_a exception_expected
            expect(exception_raised.message).to eq "Sample message"
          end
        end
      end
    end
  end

  context "with any HTTP error code" do
    let(:status) { rand(400..599) }

    it "exception contains api response" do
      expect { middleware.send(:on_complete, env) }.to raise_error do |exception_raised|
        expect(exception_raised).to be_a Devengo::Errors::Http
        expect(exception_raised.api_response).to eq api_response
      end
    end
  end

  context "when is a successful HTTP code" do
    let(:status) { rand(200..399) }

    it "not raise exception" do
      expect { middleware.send(:on_complete, env) }.not_to raise_error
    end
  end
end
