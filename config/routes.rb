Rails.application.routes.draw do
  root to: 'nba/player#show', id: 'damian-lillard-2205'
  namespace :nba do
    resources :player, only: [:show]
  end
  get '/search/suggest', to: 'search#suggest'
end
