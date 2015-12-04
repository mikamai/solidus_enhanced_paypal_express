source 'https://rubygems.org'

gem 'rails', '4.2.4'
gem 'mysql2', '< 0.4'
gem 'sass-rails', '~> 5.0'
gem 'sassc-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'browserify-rails'
gem 'jquery-rails'
gem 'font-awesome-sass', '~> 4.4.0'
gem 'rails-i18n', github: 'svenfuchs/rails-i18n', branch: 'master' # For 4.x


# Solidus!
gem 'solidus'
gem 'solidus_auth_devise'
gem 'recipient_interceptor'

#payment methods
gem "solidus_braintree", github: 'dfranciosi/solidus_braintree', branch: 'mysql-legacy-support'
#official solidus gateways
gem "solidus_gateway"
gem 'solidus_i18n', github: 'solidusio-contrib/solidus_i18n', branch: 'master'
gem 'solidus_globalize', github: 'solidusio-contrib/solidus_globalize', branch: 'master'
gem 'solidus_simple_weight_calculator', github: 'dfranciosi/solidus_simple_weight_calculator', branch: 'master'

group :development do
  gem 'spring'
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'guard', require: false
  gem 'rb-fsevent', require: false, install_if: ->() { `uname` =~ /darwin/i }
  gem 'rack-livereload'
  gem 'guard-livereload', require: false
  gem 'guard-bundler', require: false
  gem 'guard-pow', require: false
  gem 'capistrano', '~> 3.4.0', require: false
  gem 'capistrano-bundler', '~> 1.1.4', require: false
  gem 'capistrano-passenger', '0.1.1', require: false
  gem 'capistrano-rails', '~> 1.1.3', require: false
  gem 'capistrano-rbenv', '~> 2.0.3', require: false
  gem 'capistrano-npm', require: false
  gem 'slackistrano', require: false
end

group :test do
  gem 'spring-commands-rspec', require: false
  gem 'rspec-rails', require: false
  gem 'guard-rspec', require: false
end
