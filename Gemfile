# frozen_string_literal: true

source 'https://rubygems.org'

gem 'config', '~> 1.7.1'

gem 'dry-initializer', '~> 2.5.0'
gem 'dry-monads', '~> 1.1.0'
gem 'dry-transaction', '~> 0.13.0'
gem 'dry-validation', '~> 0.13.1'
gem 'dry-struct', '~> 0.6.0'
gem 'dry-auto_inject', '~> 0.6.0'

#gem 'honeybadger', '~> 4.1'

gem 'zeitwerk', '>= 1.3.1'

# on production Lambda, they will be included via layer
group :development, :test do
  # add Gemfile.exts deps also here
  #gem 'nokogiri'
end

group :development, :test do
  gem 'rb-readline'
  gem 'rubocop', '>= 0.65'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rack'
  gem 'shotgun'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'rspec'
  gem 'database_cleaner'
  gem 'faker'
  gem 'factory_bot'
end
