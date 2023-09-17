source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '3.1.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '7.0.5'

# Use Puma as the app server
gem 'puma', ">= 5.6.2"

# Use SCSSC for stylesheets
gem 'sassc-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#gem 'haml-rails', '~> 2.0.0'
gem 'haml-rails'
gem 'rails-controller-testing'
gem 'bcrypt'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'rails-i18n'
gem "loofah"
gem "rubyzip"
gem "rack"
gem "nokogiri"
gem "actionview"

gem 'pg'

gem 'draper'

# actionpack upgrade (2022-02-05)
gem "actionpack", ">= 6.0.4.2"

gem 'psych', '~> 3.1'

gem 'net-smtp', require: false
gem 'net-imap', require: false
gem 'net-pop', require: false

gem 'bootstrap', '~> 5.2.0'
gem 'popper_js'
gem 'kaminari'
gem 'bootstrap5-kaminari-views'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'minitest-ci'
  gem 'dotenv-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'

  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
end

group :test do
  gem 'rspec-rails'
  gem "factory_bot_rails"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
