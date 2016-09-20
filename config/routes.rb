Rails.application.routes.draw do
  
  root to: 'users#index'
  resources :users
  resources :articles
  get '/login' => 'sessions#new', as: 'login'
  # post '/create' => 'sessions#create'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new', as: 'signup'
  post '/signup' => 'users#create'
  delete '/logout' => 'sessions#destroy'
  get '/auth/facebook/callback' => 'sessions#create'
end
