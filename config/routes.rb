Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount Raddocs::App => '/api_docs'

  resources :users do
    resources :operations
    resources :balances
  end
  post 'signup', to: 'users#create'
  post 'auth/login', to: 'authentication#authenticate'
end
