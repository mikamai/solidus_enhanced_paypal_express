source 'https://rubygems.org'

gem 'rails', '~> 4.2.5'
gem 'mysql2', '< 0.4'
gem 'sass-rails', '~> 5.0'
gem 'sassc-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails', '< 4.0'
gem 'font-awesome-sass', '~> 4.4.0'
gem 'dbmanager'
gem 'route_translator'
gem 'browserify-rails'
gem 'wicked_pdf'


# Solidus!
#gem 'solidus', '~> 1.3.0'
gem 'solidus', github: 'solidusio/solidus', branch: 'master'
gem 'solidus_auth_devise'
gem 'recipient_interceptor'
gem 'solidus_cmd'
#payment methods
gem 'solidus_braintree_vzero', git: 'git@gitlab.com:cayennelabs/solidus_braintree_vzero.git', branch: 'solidus-porting'
gem 'solidus_braintree'
#official solidus gateways
gem "solidus_gateway", github: 'dfranciosi/solidus_gateway', branch: 'remove-activemerchant-version-lock'
gem 'solidus_i18n', github: 'luukveenis/solidus_i18n', branch: 'update-it-translations'
gem 'solidus_globalize', github: 'solidusio-contrib/solidus_globalize', branch: 'master'
gem 'solidus_simple_weight_calculator', github: 'dfranciosi/solidus_simple_weight_calculator', branch: 'master'
gem 'spree_paypal_express', github: 'mikamai/solidus_paypal_express'
gem 'solidus_editor', github: 'solidusio-contrib/solidus_editor', branch: 'master'

gem 'rollbar'
gem 'oj', '~> 2.12.14'

group :development do
  gem 'better_errors'
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
  gem 'capistrano-npm'
  gem 'slackistrano', require: false
  gem 'capistrano-db-tasks', require: false
  gem "letter_opener"
end

group :test do
  gem 'spring-commands-rspec', require: false
  gem 'rspec-rails', require: false
  gem 'guard-rspec', require: false
end
