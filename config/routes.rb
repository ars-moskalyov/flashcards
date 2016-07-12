Rails.application.routes.draw do
  root to: 'home#index'
  post 'trainer/review'
  resources :cards
  resources :users, only: [:new, :create]
  resources :user_sessions, only: [:create, :destroy]

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
end
