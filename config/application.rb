require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Workspace
  class Application < Rails::Application
    config.web_console.whiny_requests = false
    #config.autoload_paths += %W(#{config.root}/lib)
    config.eager_load_paths += ["#{config.root}/app/workers"]
    config.active_record.raise_in_transactional_callbacks = true
  end
end
