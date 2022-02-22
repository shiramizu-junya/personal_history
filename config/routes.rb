Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # Topページ
  root "static_pages#top"
  # 利用規約・プライバシーポリシー
  get "terms", to: "static_pages#terms"
  get "privacy", to: "static_pages#privacy"
  # ユーザー登録関係
  resources :users, only: %i[new create destroy]
  # ログイン/ログアウト関係
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  # プロフィール関係
  resource :profile, only: %i[show edit update]
  # 自分史関係
  resources :my_histories, only: %i[index show new edit update], shallow: true do
    # コメント関係
    resources :comments, only: %i[create update destroy]
  end
  # パスワードリマインダー
  resources :password_resets, only: %i[new create edit update]
  # いいね関係
  resources :likes, only: %i[create destroy]
  # API通信関係
  namespace :api, {format: "json"} do
    resource :profile, only: %i[show update]
    resources :events, only: %i[create update destroy]
    resource :my_history, only: %i[edit create update] do
      collection do
        get :graph_data
        patch :graph_image_upload
      end
    end
  end
end
