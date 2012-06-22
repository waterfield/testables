require 'httparty'
require 'runner'
require 'rspec_runner'

namespace :task do  
  desc "Runs a single task from the server"
  task :run => :environment do
    raw = HTTParty.get('http://testables.dev/tasks.json').body
    task = JSON.parse(raw).with_indifferent_access
    runner = Runner.build task
    runner.execute
    HTTParty.post 'http://testables.dev/tasks/done', runner.result
    # send result to server
  end
end
