ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

RSpec.configure do |config|
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.order = :random
end
