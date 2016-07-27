require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Flashcards
  class Application < Rails::Application
    config.time_zone = 'Moscow'
    config.i18n.default_locale = :en

    config.action_mailer.delivery_method = :postmark
    config.action_mailer.postmark_settings = { :api_token => ENV["POSTMARK_TOKEN"] }
    config.action_mailer.default_url_options = { host: 'flashcards-62446.herokuapp.com' }

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
