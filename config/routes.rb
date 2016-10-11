Rails.application.routes.draw do
  
  root to: 'users#index'
  resources :users
  
  resources :articles do
    resources :reviews
    resources :comments do
      resources :comments
    end    
  end
  
  resources :comments do
    resources :comments
  end

  post '/likes' => 'likes#create', as: :like_create
  post '/dislikes' => 'likes#dislike', as: :dislike_create

  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new', as: 'signup'
  post '/signup' => 'users#create'
  delete '/logout' => 'sessions#destroy'
  # get '/comments/:id/edit' => 'comments#update'
  # post '/comments/:id' => 'articles#show'

  get '/auth/facebook/callback' => 'sessions#create'
  get '/auth/twitter/callback' => 'sessions#create'
  get '/auth/google_oauth2/callback' => 'sessions#create'
end
