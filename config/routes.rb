Rails.application.routes.draw do
  devise_for :users

  root 'main_page#homepage'

  resources :order_items
  resources :posts
  resources :books
  resources :reviews
  resources :pages
end
