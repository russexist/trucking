# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users

    get '/change_status', to: 'orders#change_status'
    get '/delete_avatar', to: 'application#delete_avatar'
    get '/profile', 	    to: 'application#profile'
    get '/taken_orders',  to: 'orders#taken_orders'

    get 'mailbox/inbox',  to: 'mailbox#inbox', as: :mailbox_inbox
    get 'mailbox/sent',   to: 'mailbox#sent',  as: :mailbox_sent
    get 'mailbox/trash',  to: 'mailbox#trash', as: :mailbox_trash

    resources :avatars
    resources :archive_orders, only: %i[index create show destroy]
    resources :conversations do
      # resources :messages
      member do
        post :reply
        post :trash
        post :untrash
      end
    end
    resources :orders

    root 'orders#index'
  end
end
