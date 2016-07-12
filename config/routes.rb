Rails.application.routes.draw do
  root to: 'home#index'
  post 'trainer/review'
  resources :cards
  resources :users
end
