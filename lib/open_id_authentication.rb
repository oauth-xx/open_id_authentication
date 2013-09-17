require "open_id_authentication/version"
require "open_id_authentication/middleware"
require "open_id_authentication/controller_methods"
require "open_id_authentication/railtie" if defined?(::Rails::Railtie)

module OpenIdAuthentication
  # deprecated middleware creation
  def self.new(*args)
    raise "Use OpenIdAuthentication::Middleware"
  end

  def self.store
    Middleware.store
  end

  def self.store=(*args)
    Middleware.store = *args
  end
end
