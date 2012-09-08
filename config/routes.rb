Testables::Application.routes.draw do
  resources :test_runs
  resources :pushes

  resources :projects do
    resources :suites
  end

  resources :tasks do
    get :pop, :on => :collection
    post :claim, :on => :collection
  end
  root to: 'test_runs#index'
end
