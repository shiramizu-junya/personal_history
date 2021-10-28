Rails.application.routes.draw do
  root "static_pages#top"
  # ユーザー登録関係
  resources :users, only: %i[new create]
  # ログイン/ログアウト関係
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  # プロフィール関係
  resource :profile, only: %i[show edit update]
  # 軌跡関係
  resources :my_histories
  # API通信関係
  namespace :api, {format: "json"} do
    resource :profile, only: %i[show update]
    resources :events, only: %i[create]
    resources :my_histories, only: %i[create update]
  end
end
