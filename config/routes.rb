# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  get '/change_status', to: 'orders#change_status'
  get '/taken_orders', to: 'orders#taken_orders'
  get '/profile', to: 'application#profile'

  resources :archive_orders, only: %i[index create show destroy]
  resources :conversations do
    resources :messages
  end
  resources :destinations
  resources :orders
  resources :starts

  root 'orders#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
