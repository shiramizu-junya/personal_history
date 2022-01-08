Rails.application.routes.draw do
  # Topページ
  root "static_pages#top"
  # ユーザー登録関係
  resources :users, only: %i[new create]
  # ログイン/ログアウト関係
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  # プロフィール関係
  resource :profile, only: %i[show edit update]
  # 自分史関係
  resources :my_histories, only: %i[index show new edit update]
  # いいね
  resources :likes, only: %i[create destroy]
  # API通信関係
  namespace :api, {format: "json"} do
    resource :profile, only: %i[show update]
    resources :categories, only: %i[index]
    resources :events, only: %i[create update destroy]
    resource :my_history, only: %i[edit create update]
  end
end
