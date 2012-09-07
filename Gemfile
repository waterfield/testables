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

# Heroku doesn't like the :assets group
# group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier',     '>= 1.0.3'
  gem 'haml-rails'
  gem 'less'
# end

group local(:test) do
  gem 'rspec-rails'
  gem 'mongoid-rspec'
  gem 'database_cleaner'
end

group local(:client) do
  gem 'her'
end

gem 'jquery-rails'
