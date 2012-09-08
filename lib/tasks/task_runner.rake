if %(development test).include?(Rails.env)

  # Require the :client group from the Gemfile
  Bundler.require :client

  # Point to local host in development mode,
  # or heroku otherwise. You can override the URL
  # by specifying it on the command line:
  #
  #     rake task:run URL=http://the.interne.ts/
  url = if ENV['URL'].present?
    ENV['URL']
  elsif Rails.env.development?
    "http://testables.dev"
  else
    "http://testabl.es"
  end

  # Set up +Her+ with the default middleware, and point it
  # at `http://testables.dev`.
  Her::API.setup :url => url do |faraday|
    faraday.request :url_encoded
    faraday.use Her::Middleware::DefaultParseJSON
    faraday.adapter Faraday.default_adapter
  end

  require 'client/worker'

  namespace :task do

    desc "Start worker process that runs tasks as available"
    task :run => :environment do
      Client::Worker.new.run
    end

  end
end
