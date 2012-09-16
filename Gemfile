source 'https://rubygems.org'


# We rename local groups to :test so that Heroku
# will ignore them.
def local group
  ENV['HOME'].gsub('/', '') == 'app' ? :test : group
end


gem 'rails', '3.2.3'
gem 'heroku'
gem 'twitter-bootstrap-rails'
gem 'mongoid'
gem 'devise'
gem 'bson_ext'
gem 'decent_exposure'
gem 'state_machine'
gem 'simple_form'

# Heroku doesn't like the :assets group
# group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier',     '>= 1.0.3'
  gem 'haml-rails'
  gem 'less'
# end

group local(:test) do
  gem 'rspec-rails', '>= 2.11.0'
  gem 'mongoid-rspec'
  gem 'database_cleaner'

  # This commit adds JSON formatter support, which will be
  # available with rspec-core 2.11.2.
  gem 'rspec-core', git: 'https://github.com/rspec/rspec-core', ref: '7e076bc82e925cf7918cced25b09d84f909bc4d5'
end

group local(:client) do
  gem 'her'
end

gem 'jquery-rails'
