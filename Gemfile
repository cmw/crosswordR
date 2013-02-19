source 'https://rubygems.org'

gem 'rails', '3.2.11'

gem 'pg'
gem "mail", "~> 2.4.4"
gem 'jquery-rails'
# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', :require => 'bcrypt'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'taps', :require => false #has an sqlite dependency, which heroku hates
  gem 'sqlite3'

  #Recently added debugging gems
  gem 'pry-rails'
  gem 'pry-debugger'
  gem 'pry-stack_explorer'

  gem 'annotate'

  gem 'quiet_assets'
  gem 'better_errors'

  gem 'binding_of_caller'
  gem 'meta_request'
end