Rails.application.routes.draw do
  resources :users do
    resources :operations
    resources :balances
  end
  post 'signup', to: 'users#create'
  post 'auth/login', to: 'authentication#authenticate'
end
