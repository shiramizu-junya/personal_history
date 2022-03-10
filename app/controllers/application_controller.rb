class ApplicationController < ActionController::Base
  add_flash_types :success, :danger
  before_action :require_login
  before_action :set_current_user

  if Rails.env.production?
    rescue_from Exception, with: :render_internal_server_error
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  end

  private

  def set_current_user
    # クラスメソッドとして、現在ログインしているユーザーのレコードを取得できるようにする
    User.current_user = current_user
  end

  def not_authenticated
    flash[:danger] = t("defaults.message.require_login")
    redirect_to login_path
  end

  # ログイン済みユーザーはリダイレクトさせる
  def login_decision
    redirect_to my_histories_path, danger: t("defaults.message.logged_in") if logged_in?
  end

  def render_internal_server_error(err = nil)
    logger.error("=========エラー発生 : ここから===========")
    logger.error(err.message)
    logger.error(err.backtrace.join("\n"))
    logger.error("=========エラー発生 : ここまで===========")
    render file: Rails.root.join("public/500.html"), status: :internal_server_error, layout: false, content_type: "text/html"
  end

  def render_not_found(err = nil)
    logger.error("=========エラー発生 : ここから===========")
    logger.error(err.message)
    logger.error(err.backtrace.join("\n"))
    logger.error("=========エラー発生 : ここまで===========")
    render file: Rails.root.join("public/404.html"), status: :not_found, layout: false, content_type: "text/html"
  end
end
