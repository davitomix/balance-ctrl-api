Rails.application.routes.draw do
  resources :balances do
    resources :operations
  end

  post 'signup', to: 'users#create'
  post 'auth/login', to: 'authentication#authenticate'
end
