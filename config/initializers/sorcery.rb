# Here you can configure each submodule's features.
Rails.application.config.sorcery.configure do |config|
  Rails.application.config.sorcery.submodules = [:reset_password]
  config.user_config do |user|
    user.reset_password_mailer = UserMailer
  end

  config.user_class = "User"
end
