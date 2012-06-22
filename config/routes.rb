Testables::Application.routes.draw do
  resources :test_runs
  resources :tasks do
    post :done, :on => :collection
  end
  root to: 'test_runs#index'
end
