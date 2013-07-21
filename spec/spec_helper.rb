# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'cancan/matchers'
#require 'refraction'
require 'rack/test'
require 'paperclip/matchers'
require 'database_cleaner'
require 'sidekiq/testing'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
DatabaseCleaner.strategy = :truncation

# include shared examples
Dir[Rails.root.join("spec/shared_examples/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec
  # config.fail_fast = true

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  REDIS_PID = "#{Rails.root}/tmp/pids/redis-test.pid"
  REDIS_CACHE_PATH = "#{Rails.root}/tmp/cache/"

  # config.after(:each) do
  #   Rails.cache.clear
  #   DatabaseCleaner[:mongoid].clean
  #   ActionMailer::Base.deliveries = []
  # end

  # config.before(:each) do
  #   table = double(:table)
  #   table.stub(:batch_put)
  #   Newsfeed.stub(:table).and_return(table)
  #   FacebookLike.stub(:table).and_return(table)
  # end

  config.include Paperclip::Shoulda::Matchers
#  config.include Devise::TestHelpers, type: :controller
end
