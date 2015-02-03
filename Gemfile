source 'https://rubygems.org'

ruby '2.1.2'
gem 'rails', '4.1.5'
gem 'pg'
gem 'sass-rails', '~> 4.0.3'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'will_paginate'
gem 'heroku'
gem 'devise'
gem 'rest-client'
gem 'exception_notification'
gem 'koala'
gem 'resque', require: 'resque/server'
gem 'resque-scheduler'
gem 'resque-status'

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'pry-remote'
end

group :test do
  gem 'simplecov', require: false
  gem 'shoulda-matchers'
end

group :development do
  gem 'thin'
end

group :production do
  gem 'unicorn'
  gem 'rails_12factor'
end