# External Libraries
require "version_gem"

# This library
require_relative "open_id_authentication/version"
require_relative "open_id_authentication/middleware"
require_relative "open_id_authentication/controller_methods"
require_relative "open_id_authentication/railtie" if defined?(::Rails::Railtie)

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

OpenIdAuthentication::Version.class_eval do
  extend VersionGem::Basic
end
