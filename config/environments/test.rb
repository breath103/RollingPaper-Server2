RollingPaper::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Configure static asset server for tests with Cache-Control for performance
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"

  # Log error messages when you accidentally call methods on nil
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr
  
  ASSET_HOST = "0.0.0.0:3000"  
  
  Paperclip.options[:command_path] = "/opt/local/bin/"

  config.paperclip_defaults = {
    :storage => :s3,
    :s3_credentials => {
      :bucket => "rollingpaper",
      :access_key_id => "AKIAIL54PVLZG4DXFD4A",
      :secret_access_key => "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"
    }
  }
  
  ENV["FACEBOOK_APP_ID"] = "333864290041286"
  ENV["FACEBOOK_APP_SECRET"] = "0a7e83a01bdeed5741aff7c001070c7e"
end
