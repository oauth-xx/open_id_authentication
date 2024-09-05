require_relative "lib/open_id_authentication/version"

Gem::Specification.new do |spec|
  spec.name = "open_id_authentication2"
  spec.version = OpenIdAuthentication::VERSION
  spec.summary = "Provides a thin wrapper around the excellent rack-openid2 gem."
  spec.authors = ["Peter Boling", "Patrick Robertson", "Michael Grosser"]
  spec.email = "peter.boling@gmail.com"
  spec.homepage = "https://github.com/VitalConnectInc/#{spec.name}"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir[
    # Splats (alphabetical)
    "lib/**/*.rb",
    # Files (alphabetical)
    "LICENSE.txt",
    "README.md",
  ]

  spec.license = "MIT"
  spec.required_ruby_version = '>= 2.7.0'

  spec.add_dependency("rack-openid2", "~> 2.0", ">= 2.0.1")
end
