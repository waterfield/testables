Testables::Application.routes.draw do
  resources :test_runs
  root to: 'test_runs#index'
end
