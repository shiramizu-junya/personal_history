class ApplicationController < ActionController::Base
  add_flash_types :success, :danger
  before_action :require_login
  before_action :set_current_user

  private

  def set_current_user
    # クラスメソッドとして、現在ログインしているユーザーのレコードを取得できるようにする
    User.current_user = self.current_user
  end

  def not_authenticated
    flash[:danger] = t("defaults.message.require_login")
    redirect_to login_path
  end

  # ログイン済みユーザーはリダイレクトさせる
  def login_decision
    redirect_to my_histories_path, danger: t("defaults.message.logged_in") if logged_in?
  end
end
