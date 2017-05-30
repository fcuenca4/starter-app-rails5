Rails.application.routes.draw do
  get '/sign_up',   to: 'users#new'
  post '/sign_up',  to: 'users#create'
  get '/log_in',     to: 'sessions#new'
  post '/log_in',    to: 'sessions#create'
  delete '/log_out', to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end