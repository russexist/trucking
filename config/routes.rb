# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
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
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
