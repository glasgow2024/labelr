source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.8", ">= 7.0.8.1"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 6.0"

gem "mysql2"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem 'devise'
gem 'kaminari'
gem 'nilify_blanks'
gem 'jsonapi-serializer'
gem 'jsonapi.rb'
gem "nokogiri"
gem 'pundit'
gem 'ransack'
gem "vite_rails", "~> 3.0"
gem 'vite_plugin_legacy'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "cypress-rails"
end

group :development do
  gem 'rubocop'
end

group :test do
  gem 'database_cleaner-active_record'
end
