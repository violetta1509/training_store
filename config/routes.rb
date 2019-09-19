Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    sessions: 'users/sessions',
                                    registrations: 'users/registrations' }
  ActiveAdmin.routes(self)

  root 'main_page#homepage'

  resources :order_items, only: %i[create update destroy]
  resources :books, only: %i[show index]
  resources :reviews, only: :create
  resources :orders, only: %i[index show]
  resources :coupons, only: :update
  resource :checkout_step, only: %i[show update]
  resource :cart, only: :show

  get 'settings' => 'users#edit'
  patch 'settings' => 'users#update'
  patch 'coupons' => 'coupons#update'
  patch 'order_items' => 'order_items#update'
end
