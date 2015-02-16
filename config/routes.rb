Rails.application.routes.draw do
  root 'games#index'
  devise_for :users

  resources :games, only: [:index, :show, :create]
end
