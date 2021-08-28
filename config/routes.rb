Rails.application.routes.draw do
  resources :users, only: %i[new create]
  resources :tracks
end
