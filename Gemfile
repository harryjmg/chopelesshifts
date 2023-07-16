source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"
gem "rails", "~> 7.0.5"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

gem "bootstrap"
gem "sassc-rails"
gem "hashid-rails", "~> 1.0"
gem 'rack-attack'
gem 'font-awesome-sass'

gem 'rails-i18n'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'guard'
  gem 'guard-minitest'
end

group :development do
  gem "web-console"
  gem "rails_live_reload"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "sorcery", "~> 0.16.5"
