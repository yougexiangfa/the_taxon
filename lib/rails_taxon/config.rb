require 'active_support/configurable'

module RailsTaxon
  include ActiveSupport::Configurable

  configure do |config|
    config.admin_controller = 'AdminController'
    config.my_controller = 'MyController'
    config.app_controller = 'ApplicationController'
    config.disabled_models = []
  end

end
