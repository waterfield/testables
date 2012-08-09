source 'https://rubygems.org'

#ruby         '1.9.3'
# gem 'bundler', '1.2.0.rc'
gem 'rails', '3.2.3'
gem 'heroku'
gem 'twitter-bootstrap-rails'
gem 'mongoid'
gem 'devise'
gem 'bson_ext'
gem 'decent_exposure'

# NOTE: we removed the asset group because heroku maybe doesn't like it
gem 'sass-rails',   '~> 3.2.3'
gem 'coffee-rails', '~> 3.2.1'
gem 'uglifier',     '>= 1.0.3'
gem 'haml-rails'
gem 'less'

group :test do
  gem 'rspec-rails'
  gem 'mongoid-rspec'
  gem 'database_cleaner'
end

# NOTE: We're using 'development' here, rather than the more
# appropriate 'client', because Heroku's Cedar stack doesn't
# support the BUNDLE_WITHOUT configuration, and instead always
# uses `--without development:test`. And httparty seems to
# break heroku.
group :development do
  gem 'httparty'
end

gem 'jquery-rails'
