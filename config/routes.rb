Testables::Application.routes.draw do
  resources :test_runs
  resources :projects
  resources :pushes
  resources :tasks do
    get :pop, :on => :collection
  end
  root to: 'test_runs#index'
end
