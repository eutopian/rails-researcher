Rails.application.routes.draw do
  
  root to: 'users#index'
  resources :users
  get '/signin' => 'sessions#new'
  post '/create' => 'sessions#create'
  post '/signin' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/auth/facebook/callback' => 'sessions#create'
end
