# Get the GEMFILE_VERSION without *require* "my_gem/version", for code coverage accuracy
# See: https://github.com/simplecov-ruby/simplecov/issues/557#issuecomment-825171399
load "lib/open_id_authentication/version.rb"
gem_version = OpenIdAuthentication::Version::VERSION
OpenIdAuthentication::Version.send(:remove_const, :VERSION)

Gem::Specification.new do |spec|
  spec.name = "open_id_authentication2"
  spec.version = gem_version
  spec.summary = "Provides a thin wrapper around the excellent rack-openid2 gem."
  spec.authors = ["Peter Boling", "Patrick Robertson", "Michael Grosser", "Joshua Peek", "David Heinemeier Hansson"]
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
