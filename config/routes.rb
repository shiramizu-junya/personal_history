Rails.application.routes.draw do
  root "static_pages#top"
  # ユーザー登録関係
  resources :users, only: %i[new create]
  # ログイン/ログアウト関係
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  # 軌跡関係
  resources :tracks, only: %i[index]
end
