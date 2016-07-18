Rails.application.routes.draw do
  root to: 'home#index'
  post 'trainer/review'

  resource :registration, only: [:new, :create], path_names: { new: '' }

  resources :decks, except: :show do
    resources :cards, except: :show
    post 'set_default'
  end

  resource :users, only: [:edit, :update]
  get 'login' => 'sessions#new', :as => :login
  post 'logout' => 'sessions#destroy', :as => :logout

  resources :sessions, only: [:create, :destroy]
end
