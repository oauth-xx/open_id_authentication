require 'uri'
require 'openid'
require 'rack/openid'

module OpenIdAuthentication
  class Middleware
    # middleware creation
    def self.new(app)
      if store.nil?
        Rails.logger.warn "OpenIdAuthentication.store is nil. Using in-memory store."
      end

      ::Rack::OpenID.new(app, store)
    end

    def self.store
      @@store
    end

    def self.store=(*store_option)
      store, *args = *([ store_option ].flatten)

      @@store = case store
      when :memory
        require 'openid/store/memory'
        OpenID::Store::Memory.new
      when :file
        require 'openid/store/filesystem'
        OpenID::Store::Filesystem.new(Rails.root.join('tmp/openids'))
      when :memcache
        require 'memcache'
        require 'openid/store/memcache'
        OpenID::Store::Memcache.new(MemCache.new(args))
      else
        store
      end
    end

    self.store = nil
  end
end
