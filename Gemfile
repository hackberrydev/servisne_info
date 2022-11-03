source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "rails", "~> 6.1.7"

gem "aws-sdk-s3", "~> 1.60"
gem "bootstrap", "~> 4.3.1"
gem "devise"
gem "jquery-rails"
gem "kaminari"
gem "lograge"
gem "mechanize"
gem "pg", ">= 0.18", "< 2.0"
gem "pg_search"
gem "puma", "~> 5.2"
gem "sass-rails", "~> 5.0"
gem "sentry-raven"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "whenever", require: false

group :development, :test do
  gem "byebug"
  gem "factory_bot_rails"
  gem "rspec-rails"
end

group :development do
  gem "capistrano-rails"
  gem "capistrano3-puma"
  gem "capistrano-bundler"
  gem "capistrano-rbenv"
  gem "listen", ">= 3.0.5", "< 3.2"
end

group :test do
  gem "capybara"
  gem "webmock"
  gem "vcr", "~> 4.0"
end
