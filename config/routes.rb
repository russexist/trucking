# frozen_string_literal: true

Rails.application.routes.draw do
  resources :destinations
  resources :starts
  resources :orders
  devise_for :users

  get '/change_status', to: 'orders#change_status'
  get '/taken_orders', to: 'orders#taken_orders'
  get '/profile', to: 'application#profile'

  root 'orders#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
