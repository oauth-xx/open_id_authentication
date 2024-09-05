module OpenIdAuthentication
  class Railtie < ::Rails::Railtie
    config.app_middleware.use(OpenIdAuthentication::Middleware)

    config.after_initialize do
      OpenID::Util.logger = Rails.logger
    end

    ActiveSupport.on_load(:action_controller) do
      ActionController::Base.send(:include, ControllerMethods)
    end
  end
end
