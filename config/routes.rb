Rails.application.routes.draw do
  root to: 'home#index'
  post 'trainer/review'

  resource :registration, only: [:new, :create], path_names: { new: '' }

  resources :decks do
    resources :cards, only: [:index, :new, :create]
    post 'set_default'
  end
  resources :cards, only: [:edit, :update, :destroy]

  resource :users, only: [:edit, :update]
  get 'login' => 'sessions#new', :as => :login
  post 'logout' => 'sessions#destroy', :as => :logout

  resources :sessions, only: [:create, :destroy]
end
