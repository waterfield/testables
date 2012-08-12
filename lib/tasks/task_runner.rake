if %(development test).include?(Rails.env)

  # Require the :client group from the Gemfile
  Bundler.require :client

  # Set up +Her+ with the default middleware, and point it
  # at `http://testables.dev`.
  Her::API.setup :url => "http://testables.dev" do |faraday|
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
