Rails.application.config.sorcery.submodules = [:reset_password, :external]
Rails.application.config.sorcery.configure do |config|

  config.external_providers = %i[google]

  config.google.key = Rails.application.credentials.dig(:google, :client_id)
  config.google.secret = Rails.application.credentials.dig(:google, :client_secret)
  config.google.callback_url = Rails.env.production? ? 
                               "https://pictomemory.com/oauth/callback?provider=google" : 
                               "http://localhost:3000/oauth/callback?provider=google"
  config.google.user_info_mapping = {:email => "email", :name => "name"}

  config.user_class = "User"

  config.user_config do |user|
    user.reset_password_mailer = UserMailer
    user.authentications_class = Authentication
  end

end
