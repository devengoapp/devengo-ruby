# frozen_string_literal: true

require "devengo"
require "timecop"
require "webmock/rspec"

WebMock.disable_net_connect!

RSPEC_ROOT = File.expand_path(__dir__) unless defined?(RSPEC_ROOT)
Dir[File.join(RSPEC_ROOT, "support/**/*.rb")].sort.each { |f| require f }

RSpec.configure do |config|
  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # This setting enables warnings. It's recommended, but in some cases may
  # be too noisy due to issues in dependencies.
  config.warnings = true

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Devengo::HelperMethods

  # Create authentication stub for those test suites within :api :integration tags
  config.before(:example, :integration, type: :api) do |example|
    next if example.metadata[:authenticate] == false

    stub_request(:post, %r{/auth/tokens}).to_return(read_http_response_fixture("auth/login", "success"))
  end
end
