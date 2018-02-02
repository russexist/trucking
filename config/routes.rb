Rails.application.routes.draw do
  resources :orders
  devise_for :users

  root 'orders#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
