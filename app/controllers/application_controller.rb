class ApplicationController < ActionController::Base
  add_flash_types :success, :danger
  before_action :require_login

  private

  def not_authenticated
    flash[:danger] = t("defaults.message.require_login")
    redirect_to login_path
  end

  # ログイン済みユーザーはリダイレクトさせる
  def login_decision
    if logged_in?
      redirect_to tracks_path, danger: t("defaults.message.logged_in")
    end
  end
end
