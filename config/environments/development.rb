# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  # Bulletの設定
  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true # ブラウザのJavaScriptアラートとして警告を表示
    Bullet.bullet_logger = true # log/bullet.logへのログ記録
    Bullet.console = true # ブラウザのコンソールログに警告を表示
    Bullet.rails_logger = true # Railsのログに警告を出力
    Bullet.add_footer = true # 画面下部に警告を表示
  end

  # better_errorsをdocker上で使えるようにするための設定
  BetterErrors::Middleware.allow_ip! "0.0.0.0/0"


  config.enable_reloading = true
  config.eager_load = false

  config.consider_all_requests_local = true

  config.server_timing = true

  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.active_storage.service = :amazon

  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  config.active_support.deprecation = :log

  config.active_support.disallowed_deprecation = :raise

  config.active_support.disallowed_deprecation_warnings = []

  config.active_record.migration_error = :page_load

  config.active_record.verbose_query_logs = true

  config.active_job.verbose_enqueue_logs = true

  config.assets.quiet = true

  config.action_controller.raise_on_missing_callback_actions = true

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # 開発環境でのメーラー設定
  config.action_mailer.delivery_method = :letter_opener_web
end
