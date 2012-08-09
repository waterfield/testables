if %(development test).include?(Rails.env)
  require 'httparty'
  require 'runner'
  require 'rspec_runner'

  host = 'testables.dev'

  namespace :task do
    desc "Runs a single task from the server"
    task :run => :environment do
      raw = HTTParty.get("http://#{host}/tasks.json").body
      task = JSON.parse(raw).with_indifferent_access
      runner = Runner.build task
      runner.execute
      HTTParty.post "http://#{host}/tasks/done", body: runner.result
      # send result to server
    end
  end
end
