Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy, :show, :update]
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'user_stock/:id/edit', to: 'user_stocks#show'
  put 'user_stock/:id', to: 'user_stocks#update'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'my_list', to: 'users#my_list'
  get 'my_friendlist', to: 'users#my_friendlist'
  get 'search_stock', to: 'stocks#search'
  get 'search_friend', to: 'users#search_friend'
  resources :friendships, only: [:create, :destroy]
  resources :users, only: [:show]
end
