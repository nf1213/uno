Rails.application.routes.draw do
  root 'games#index'
  devise_for :users
  get '/games/:id/play/:card_id', to: 'games#play_card', as: :play_card
  resources :games, only: [:index, :show, :create]
end
