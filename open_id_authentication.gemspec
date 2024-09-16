# Get the GEMFILE_VERSION without *require* "my_gem/version", for code coverage accuracy
# See: https://github.com/simplecov-ruby/simplecov/issues/557#issuecomment-825171399
load "lib/open_id_authentication/version.rb"
gem_version = OpenIdAuthentication::Version::VERSION
OpenIdAuthentication::Version.send(:remove_const, :VERSION)

Gem::Specification.new do |spec|
  spec.name = "open_id_authentication"
  spec.version = gem_version
  spec.summary = "Provides a thin wrapper around the excellent rack-openid2 gem."
  spec.authors = ["Peter Boling", "Patrick Robertson", "Michael Grosser", "Joshua Peek", "David Heinemeier Hansson"]
  spec.email = "peter.boling@gmail.com"
  spec.homepage = "https://github.com/oauth-xx/#{spec.name}"

  # See CONTRIBUTING.md
  spec.cert_chain = [ENV.fetch("GEM_CERT_PATH", "certs/#{ENV.fetch("GEM_CERT_USER", ENV["USER"])}.pem")]
  spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $PROGRAM_NAME.end_with?("gem")

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir[
    # Splats (alphabetical)
    "lib/**/*.rb",
    # Files (alphabetical)
    "CHANGELOG.md",
    "CODE_OF_CONDUCT.md",
    "CONTRIBUTING.md",
    "LICENSE.txt",
    "README.md",
    "SECURITY.md"
  ]
  spec.executables = spec.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  spec.licenses = ["MIT"]
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "#{spec.homepage}/tree/v#{spec.version}"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/v#{spec.version}/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "#{spec.homepage}/issues"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/#{spec.name}/#{spec.version}"
  spec.metadata["wiki_uri"] = "#{spec.homepage}/wiki"
  spec.metadata["funding_uri"] = "https://liberapay.com/pboling"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.add_dependency("rack-openid2", "~> 2.0", ">= 2.0.1")
  spec.add_dependency("version_gem", "~> 1.1", ">= 1.1.4")

  # Coverage
  spec.add_development_dependency("kettle-soup-cover", "~> 1.0", ">= 1.0.2")

  # Testing
  spec.add_development_dependency("rake", ">= 13")
  spec.add_development_dependency("rspec", ">= 3")
  spec.add_development_dependency("rspec-block_is_expected", "~> 1.0", ">= 1.0.5")

  # Linting
  spec.add_development_dependency("rubocop-lts", "~> 18.2", ">= 18.2.1")
  spec.add_development_dependency("rubocop-minitest", "~> 0.36")
  spec.add_development_dependency("rubocop-packaging", "~> 0.5", ">= 0.5.2")
  spec.add_development_dependency("rubocop-rspec", "~> 2.10")
  spec.add_development_dependency("standard", ">= 1.35.1")

  # Documentation
  spec.add_development_dependency("yard", "~> 0.9", ">= 0.9.34")
  spec.add_development_dependency("yard-junk", "~> 0.0.10")
end