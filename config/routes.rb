# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    get 'archive',         to: 'orders#archive'
    get 'change_status',   to: 'orders#change_status'
    get 'delivered',       to: 'orders#delivered'
    get 'mailbox/inbox',   to: 'mailbox#inbox'
    get 'mailbox/sentbox', to: 'mailbox#sentbox'
    get 'taken',           to: 'orders#taken'
    get 'taken_orders',    to: 'orders#taken_orders'

    resources :avatars, except: %i[index show]
    resources :conversations do
      member do
        delete :destroy_message
        post :reply
      end
    end
    resources :notifications, only: %i[destroy index] do
      post :mark_as_read, on: :collection
    end
    resources :orders
    resources :users, only: :show do
      resources :reviews
    end

    root 'orders#index'
  end
end
