source 'https://rubygems.org'

gem 'rails'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'thin'
gem 'pg'
gem 'haml-rails'
gem 'nifty-generators'
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem "bootstrap-sass"
gem 'json'
gem 'gmaps4rails'
gem "heroku"
gem "figaro"
gem 'inherited_resources'

# Platform dependent gems
if RUBY_PLATFORM.downcase.include?("linux")
  gem "rb-inotify"
end

# Gems used only for assets and not required
# in production environments by default.
gem "compass-rails"
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier'
end

group :development do
  gem "guard-ctags-bundler"
  gem "guard-rspec"
  gem "guard-spork"
end

group :test do
  gem "capybara"
  gem "factory_girl_rails"
  gem "faker"
end

group :development, :test do
  gem "rspec-rails"
  gem "shoulda-matchers"
end

gem "jquery-rails"
gem "jquery-ui-rails"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'
