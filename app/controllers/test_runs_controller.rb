class TestRunsController < ApplicationController
  expose(:test_runs) { TestRun.scoped }
  expose(:test_run)
  
  respond_to :html, :json
  
end