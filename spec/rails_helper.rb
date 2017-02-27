ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)
ActiveRecord::Migrator.migrations_paths = [
  File.expand_path('../dummy/db/migrate', __FILE__)
]
if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end
require 'spec_helper'
require 'rspec/rails'
require 'factory_girl_rails'

require 'spree/testing_support/factories'

Dir[SolidusLiquid::Engine.root.join('spec/support/**/*.rb')].each do |f|
  require f
end

ENV['AWS_S3_BUCKET_NAME'] ||= 'bucket-name'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
