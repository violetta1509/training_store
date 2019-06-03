Rails.application.routes.draw do
  devise_for :users, :controllers => {omniauth_callbacks: 'users/omniauth_callbacks'}

  root 'main_page#homepage'

  resources :order_items
  resources :posts
  resources :books
  resources :reviews
  resources :pages
end
