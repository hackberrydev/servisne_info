source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "rails", "~> 7.2.0"

gem "aws-sdk-s3", "~> 1.60"
gem "bootstrap", "~> 4.3"
gem "devise"
gem "jquery-rails"
gem "kaminari"
gem "lograge"
gem "mechanize"
gem "pg", "~> 1.4"
gem "pg_search", "~> 2.3"
gem "puma", "~> 5.2"
gem "sass-rails", "~> 5.0"
gem "sassc-rails"
gem "sentry-ruby"
gem "sentry-rails"
gem "sentry-sidekiq"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "whenever", require: false

group :development, :test do
  gem "byebug"
  gem "factory_bot_rails"
  gem "rspec-rails"
  gem "standard"
  gem "standard-rails"
end

group :development do
  gem "capistrano-rails"
  gem "capistrano3-puma"
  gem "capistrano-bundler"
  gem "capistrano-rbenv"
  gem "listen"
end

group :test do
  gem "capybara"
  gem "webmock"
  gem "vcr", "~> 6.0"
end
