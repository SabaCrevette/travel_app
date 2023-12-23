# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TravelApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.generators do |g|
      g.helper false # helperファイルの生成をスキップ
      g.routes false           # ルーティングの記述をスキップ
      g.javascripts false      # JSファイルの生成をスキップ
      g.test_framework :rspec # RSpecのみ生成(minitestはスキップ)
      g.request_specs false # Request specsの生成をスキップ
    end

    # i18n言語設定
    config.i18n.available_locales = %i[ja en]
    config.i18n.default_locale = :ja
    # i18nロケールファイルの読み込みパス設定
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
  end
end
