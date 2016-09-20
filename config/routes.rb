Rails.application.routes.draw do
  
  root to: 'users#index'
  resources :users
  resources :articles
  resources :comments
  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new', as: 'signup'
  post '/signup' => 'users#create'
  delete '/logout' => 'sessions#destroy'
  # delete '/articles/:id' => 'articles#destroy', as: ''
  get '/auth/facebook/callback' => 'sessions#create'
  get '/auth/twitter/callback' => 'sessions#create'
  get '/auth/google_oauth2/callback' => 'sessions#create'
end
