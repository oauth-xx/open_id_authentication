# stdlib
require "uri"

# External libraries
require "openid" # gem ruby-openid2
require "rack/openid"

module OpenIdAuthentication
  module Middleware
    class << self
      # middleware creation
      def new(app)
        if store.nil?
          OpenID::Util.logger.warn("OpenIdAuthentication.store is nil. Using in-memory store.")
        end

        ::Rack::OpenID.new(app, store)
      end

      def store
        @@store
      end

      def store=(*store_option)
        storage, *args = *[store_option].flatten

        @@store = case storage
        when :memory
          require "openid/store/memory"
          OpenID::Store::Memory.new
        when :file
          require "openid/store/filesystem"
          OpenID::Store::Filesystem.new(Rails.root.join("tmp/openids"))
        when :memcache
          require "dalli"
          require "openid/store/memcache"
          OpenID::Store::Memcache.new(Dalli::Client.new(args))
        else
          storage
        end
      end
    end

    self.store = nil
  end
end
