Testables::Application.routes.draw do
  resources :test_runs
  resources :tasks do
    get :pop, :on => :collection
  end
  resources :pushes
  root to: 'test_runs#index'
end
