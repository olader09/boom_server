require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server, at: '/cable'
  resource :player
  post :player_token, to: 'player_token#create'

end
