source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

gem "rails", github: "rails/rails", branch: "main"

gem "amazing_print", "~> 1.4"
gem "bcrypt", "~> 3.1"
gem "better_html", "~> 2.0"
gem "bootsnap", "~> 1.16", require: false
gem "config", "~> 4.1"
gem "cssbundling-rails", "~> 1.1"
gem "jbuilder", "~> 2.11"
gem "jsbundling-rails", "~> 1.1"
gem "puma", "~> 6.0"
gem "rack", "~> 2.2.4"
gem "rack-mini-profiler", "~> 3.0"
gem "sprockets-rails", "~> 3.4"
gem "sqlite3", "~> 1.6"
gem "stimulus-rails", "~> 1.2"
gem "turbo-rails", "~> 1.3"

group :development, :test do
  gem "debug", "~> 1.7"
  gem "factory_bot_rails", "~> 6.2"
  gem "rspec-core", github: "rspec/rspec-core"
  gem "rspec-expectations", github: "rspec/rspec-expectations"
  gem "rspec-mocks", github: "rspec/rspec-mocks"
  gem "rspec-rails", github: "rspec/rspec-rails"
  gem "rspec-support", github: "rspec/rspec-support"
end

group :development do
  gem "annotate", "~> 3.2", require: false
  gem "brakeman", "~> 5.4", require: false
  gem "bundle-audit", "~> 0.1.0", require: false
  gem "derailed_benchmarks", "~> 2.1", require: false
  gem "erb_lint", "~> 0.3.1", require: false
  gem "i18n-tasks", "~> 1.0", require: false
  gem "rdoc", "~> 6.5", require: false
  gem "rubocop-performance", "~> 1.15", require: false
  gem "rubocop-rails", "~> 2.17", require: false
  gem "rubocop-rake", "~> 0.6.0", require: false
  gem "rubocop-rspec", "~> 2.18", require: false
  gem "sdoc", "~> 2.6", require: false
  gem "standard", "~> 1.22", require: false
  gem "web-console", "~> 4.2"
end

group :test do
  gem "capybara", "~> 3.38", require: false
  gem "cuprite", "~> 0.14.3", require: false
  gem "database_cleaner-active_record", "~> 2.0", require: false
  gem "simplecov", "~> 0.22.0", require: false
  gem "simplecov-cobertura", "~> 2.1", require: false
  gem "site_prism", "~> 3.7", require: false
  gem "vcr", "~> 6.1", require: false
  gem "webmock", "~> 3.18", require: false
end

gem "faker", "~> 3.1"
