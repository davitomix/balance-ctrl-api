Rails.application.routes.draw do
  resources :balances do
    resources :operations
  end
end
