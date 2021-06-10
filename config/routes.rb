Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount Raddocs::App => '/api_docs'

  resources :operations
  resources :balances

  post 'signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  get 'health_check', to: 'application#health'
end
