require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
require_relative "dummy/config/environment"

require "rspec/rails"
require "vcr"
require "webmock/rspec"

require "database_cleaner/active_record"
require_relative "support/helpers/database_cleaner"

WebMock.disable_net_connect!(allow_localhost: true)

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

VCR.config do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.stub_with :webmock
  c.default_cassette_options = {record: :new_episodes}
  c.configure_rspec_metadata!
end

Dir["#{__dir__}/support/helpers/**/*.rb"].each { |f| require f }
Dir["#{__dir__}/support/shared_contexts/**/*.rb"].each { |f| require f }

require "capybara/cuprite"
Capybara.javascript_driver = :cuprite
Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(app, window_size: [1920, 1080], inspector: ENV.fetch("INSPECTOR", nil))
end
Capybara.server = :puma, {Silent: true}

RSpec.configure do |config|
  config.include ActiveSupport::Testing::TimeHelpers
  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = false

  config.filter_rails_from_backtrace!
  config.infer_spec_type_from_file_location!

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before do
    DatabaseCleaner.strategy = :transaction

    WebMock.reset!

    FileUtils.rm_rf(ActiveStorage::Blob.service.root)
  end

  config.before(:each, type: :feature) do
    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test
    DatabaseCleaner.strategy = :truncation unless driver_shares_db_connection_with_specs
  end

  config.before do
    DatabaseCleaner.start
  end

  config.append_after do
    DatabaseCleaner.clean
  end
end
