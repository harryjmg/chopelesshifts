source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"
gem "rails", "~> 7.0.5", ">= 7.0.5.1"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails", ">= 1.2.2"
gem "turbo-rails", ">= 1.5.0"
gem "stimulus-rails", ">= 1.2.2"
gem "jbuilder", ">= 2.12.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

gem "bootstrap", ">= 5.3.0"
gem "sassc-rails"
gem "hashid-rails", "~> 1.0"
gem 'rack-attack'
gem 'font-awesome-sass'

gem 'rails-i18n', '>= 7.0.8'
gem 'sidekiq'
gem 'redis'
gem 'dkim'
gem 'httparty'
gem 'mixpanel-ruby'
gem 'sib-api-v3-sdk'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'guard'
  gem 'guard-minitest'
  gem 'dotenv-rails', '>= 3.0.0'
end

group :development do
  gem "web-console", ">= 4.2.1"
  gem "rails_live_reload", ">= 0.3.5"
  gem "letter_opener"
end

group :test do
  gem "capybara", ">= 3.40.0"
  gem "selenium-webdriver"
  gem "webdrivers", ">= 5.3.0"
  gem "simplecov", require: false
end

gem "sorcery", "~> 0.16.5"
