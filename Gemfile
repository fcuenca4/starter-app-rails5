source 'https://rubygems.org'
ruby '2.3.1'
#ruby-gemset=starter_app

# Rails

gem 'rails',  '5.0.0.1'

# Default Rails gems

gem 'coffee-rails', '4.2.1'
gem 'jbuilder',     '2.6.0'
gem 'jquery-rails', '4.2.1'
gem 'sass-rails',   '5.0.6'
gem 'turbolinks',   '5.0.1'
gem 'uglifier',     '3.0.2'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data',  '1.2016.6', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Project specific gems

gem 'high_voltage',             '3.0.0'
gem 'bootstrap-sass',           '3.3.7'
gem 'bcrypt',                   '3.1.11'
gem 'will_paginate',            '3.1.3'
gem 'bootstrap-will_paginate',  '0.0.10'

# Development & testing specific gems

group :development, :test do
  gem 'byebug',   '9.0.5', platform: :mri
  gem 'sqlite3',  '1.3.11'
end

group :test do
  gem 'rails-controller-testing', '1.0.1'
  gem 'minitest-reporters',       '1.1.11'
end

# Production gems

group :production do
  gem 'passenger',  '5.0.29'
  gem 'pg',         '0.18.4'
end