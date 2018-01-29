ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'faker'

Dir[
  Rails.root.join('spec', 'support', '**', '*.rb')
].each { |file| require file }

RSpec.configure do |config|
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.order = :random
  config.use_transactional_fixtures = false

  config.include FactoryBot::Syntax::Methods
  config.include Rails.application.routes.url_helpers

  config.infer_spec_type_from_file_location!

  config.mock_with :rspec do |c|
    c.syntax = %i[should expect]
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before do
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
end
