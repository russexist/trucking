# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users

    get 'archive',         to: 'orders#archive'
    get 'change_status',   to: 'orders#change_status'
    get 'mailbox/inbox',   to: 'mailbox#inbox'
    get 'mailbox/sentbox', to: 'mailbox#sentbox'
    get 'taken_orders',    to: 'orders#taken_orders'

    resources :avatars, except: %i[index show]
    resources :conversations do
      member do
        post :reply
        delete :destroy_message
      end
    end
    resources :orders
    resources :users, only: :show do
      resources :reviews
    end

    root 'orders#index'
  end
end
