Rails.application.routes.draw do
  root "static_pages#top"
  # ユーザー登録関係
  resources :users, only: %i[new create]
  # ログイン/ログアウト関係
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  # プロフィール関係
  resource :profile, only: %i[edit update]
  # 軌跡関係
  resources :tracks
end
