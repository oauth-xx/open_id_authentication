$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
name = "open_id_authentication"
require "#{name}/version"

Gem::Specification.new name, OpenIdAuthentication::VERSION do |s|
  s.summary = "open_id_authentication provides a thin wrapper around the excellent rack-openid gem."
  s.authors = ["Patrick Robertson", "Michael Grosser"]
  s.email = "michael@grosser.it"
  s.homepage = "https://github.com/grosser/#{name}"
  s.files = `git ls-files`.split("\n")
  s.license = "MIT"
  key = File.expand_path("~/.ssh/gem-private_key.pem")
  if File.exist?(key)
    s.signing_key = key
    s.cert_chain = ["gem-public_cert.pem"]
  end
  s.add_runtime_dependency "rack-openid", "~> 1.3"
end
