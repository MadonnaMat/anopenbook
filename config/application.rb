# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require_relative '../lib/sanitize_with_css'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Anopenbook
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
      g.jbuilder false
    end

    Dir[Rails.root.join('app/serializers/**/*.rb')].sort.each { |f| require f }
  end
end
