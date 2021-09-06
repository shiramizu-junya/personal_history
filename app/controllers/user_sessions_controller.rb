class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password], params[:remember])
    if @user
      redirect_back_or_to tracks_path, success: t(".success")
    else
      flash.now[:danger] = t(".fail")
      render :new
    end
  end

  def destroy
    # ログアウト時にユーザのセッション情報を消す
    remember_me!
    forget_me!
    logout
    redirect_to root_url, success: t(".success")
  end
end
