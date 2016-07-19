source 'https://rubygems.org'
ruby '2.3.1'
#ruby-gemset=starter_app

# Rails

gem 'rails',  '5.0.0'

# Default Rails gems

gem 'coffee-rails', '4.2.1'
gem 'jbuilder',     '2.5.0'
gem 'jquery-rails', '4.1.1'
gem 'puma',         '3.4.0'
gem 'sass-rails',   '5.0.5'
gem 'turbolinks',   '5.0.0'
gem 'uglifier',     '3.0.0'

# Project specific gems

gem 'high_voltage',   '3.0.0'
gem 'bootstrap-sass', '3.3.6'
gem 'devise',         '4.2.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data',  '1.2016.6', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Development & testing specific gems

group :development do
  gem 'better_errors',          '2.1.1'
  gem 'binding_of_caller',      '0.7.2'
  gem 'listen',                 '3.1.5'
  gem 'spring',                 '1.7.2'
  gem 'spring-watcher-listen',  '2.0.0'
  gem 'web-console',            '3.3.1'
end

group :development, :test do
  gem 'byebug',   '9.0.5', platform: :mri
  gem 'sqlite3',  '1.3.11'
end

# Production gems

group :production do
  gem 'passenger',  '5.0.29'
  gem 'pg',         '0.18.4'
end