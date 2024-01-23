# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do

  config.enable_reloading = false


  config.eager_load = true


  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true


  config.assets.compile = false



  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :amazon



  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # Log to STDOUT by default
  config.logger = ActiveSupport::Logger.new($stdout)
                                       .tap  { |logger| logger.formatter = ::Logger::Formatter.new }
                                       .then { |logger| ActiveSupport::TaggedLogging.new(logger) }

  # Prepend all log lines with the following tags.
  config.log_tags = [:request_id]

  # Info include generic and useful information about system operation, but avoids logging too much
  # information to avoid inadvertent exposure of personally identifiable information (PII). If you
  # want to log everything, set the level to "debug".
  config.log_level = ENV.fetch('RAILS_LOG_LEVEL', 'info')



  config.action_mailer.perform_caching = false


  config.i18n.fallbacks = true


  config.active_support.report_deprecations = false

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  config.action_mailer.perform_caching = true

  # 本番環境で実際にメールを送信する設定
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { host: 'pictomemory.com', protocol: 'https' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'pictomemory.com',
    user_name:            ENV['GMAIL_USERNAME'],
    password:             ENV['GMAIL_PASSWORD'],
    authentication:       'plain',
    enable_starttls_auto: true 
  }

end
