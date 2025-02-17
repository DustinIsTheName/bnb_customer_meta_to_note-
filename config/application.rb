require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BnbCustomerMetaToNoteUpdate
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    ShopifyAPI::Context.setup(
      api_key: ENV.fetch('API_KEY', '').presence,
      api_secret_key: ENV.fetch('PASSWORD', '').presence,
      private_shop: ENV.fetch('SHOPIFY_DOMAIN', '').presence,
      scope: "read_orders,read_products,etc",
      session_storage: ShopifyAPI::Auth::FileSessionStorage.new, # See more details below
      is_embedded: false, # Set to true if you are building an embedded app
      api_version: "2022-01", # The version of the API you would like to use
      is_private: true, # Set to true if you have an existing private app
    )
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
