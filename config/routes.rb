Rails.application.routes.draw do
  root 'games#index'
  devise_for :users

  get '/games/:id/play/:card_id', to: 'games#play_card', as: :play_card
  get '/games/:id/colors', to: 'games#colors', as: :colors
  post '/games/:id/color/:color', to: 'games#choose_color', as: :choose_color

  resources :games, only: [:index, :show, :create]
end
