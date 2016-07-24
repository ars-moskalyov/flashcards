Rails.application.routes.draw do
  root to: 'home#index'
  post 'trainer/review'

  resource :registration, only: [:new, :create], path_names: { new: '' }

  resources :decks, except: :show do
    resources :cards, except: :show do
      post 'update_date', on: :collection
    end
    post 'set_default'
  end

  resource :users, only: [:edit, :update]
  get 'login' => 'sessions#new', as: :login
  post 'logout' => 'sessions#destroy', as: :logout
  get 'locale' => 'sessions#locale', as: :locale

  resources :sessions, only: [:create, :destroy]
end
