Rails.application.routes.draw do
  root to: 'home#index'
  post 'trainer/review'
  resources :cards
  resources :users, only: [:new, :create, :edit, :update]
  resources :sessions, only: [:create, :destroy]

  get 'login' => 'sessions#new', :as => :login
  post 'logout' => 'sessions#destroy', :as => :logout
end
