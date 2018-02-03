Rails.application.routes.draw do
  resources :orders
  devise_for :users

  get '/change_status', to: 'orders#change_status'

  root 'orders#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
