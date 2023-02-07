require_relative "lib/evematic/version"

version = Evematic::VERSION

Gem::Specification.new do |spec|
  spec.name = "evematic"
  spec.version = version
  spec.authors = ["Bokobo Shahni"]
  spec.email = ["shahni@bokobo.space"]
  spec.homepage = "https://evematic.dev"
  spec.summary = "Build EVE Online third party applications with Ruby on Rails"
  spec.description = "Evematic is a full-stack toolkit for building third party applications for EVE Online with Ruby on Rails."
  spec.license = "MIT"

  spec.required_ruby_version = ">= 3.2.0"
  spec.required_rubygems_version = ">= 3.4.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/evematic/evematic/issues",
    "changelog_uri" => "https://github.com/evematic/evematic/blob/v#{version}/CHANGELOG.md",
    "documentation_uri" => "https://api.evematic.dev/v#{version}",
    "homepage_uri" => spec.homepage,
    "mailing_list_uri" => "https://github.com/org/evematic/discussions",
    "source_code_uri" => "https://github.com/evematic/evematic/tree/v#{version}",
    "rubygems_mfa_required" => "true"
  }

  spec.files = Dir[
    "app/**/*.{rb,yml}",
    "config/**/*.{rb,yml}",
    "db/**/*.rb",
    "lib/**/*.rb",
    "public/**/*.{css,html,js}",
    "Rakefile",
    "README.md",
    "LICENSE.md"
  ]
  spec.require_paths = ["lib"]

  spec.add_dependency "dry-configurable", "~> 1.0"
  spec.add_dependency "faraday-detailed_logger", "~> 2.5"
  spec.add_dependency "faraday-http-cache", "~> 2.4"
  spec.add_dependency "faraday-retry", "~> 2.0"
  spec.add_dependency "faraday-typhoeus", "~> 1.0"
  spec.add_dependency "omniauth", "~> 2.1"
  spec.add_dependency "omniauth-eve_online", "~> 1.0.1"
  spec.add_dependency "omniauth-rails_csrf_protection", "~> 1.0"
  spec.add_dependency "rails", [">= 7.0", "<= 7.2"]
  spec.add_dependency "turbo-rails", "~> 1.3"
  spec.add_dependency "typhoeus", "~> 1.4"
  spec.add_dependency "zeitwerk", "~> 2.5"
end
