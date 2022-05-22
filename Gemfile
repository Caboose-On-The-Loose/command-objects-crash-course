source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

gem "rails", "~> 7.0.3"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.0"

group :development, :test do
  gem 'pry'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'wisper-rspec', require: false
end

gem "devise", "~> 4.8"
gem "simple_form", "~> 5.1"
gem "rectify", "~> 0.13.0"
