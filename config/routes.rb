Testables::Application.routes.draw do
  resources :test_runs, :tasks
  root to: 'test_runs#index'
end
