Rails.application.routes.draw do
  resources :users do
    resources :balances do
      resources :operations
    end
  end
  post 'signup', to: 'users#create'
  post 'auth/login', to: 'authentication#authenticate'
end
