Testables::Application.routes.draw do
  apipie

  resources :test_runs
  resources :projects
  resources :pushes

  resources :tasks do
    get :pop, :on => :collection
    post :claim, :on => :collection
  end

  root to: 'test_runs#index'
end
