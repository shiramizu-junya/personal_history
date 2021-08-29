class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new; end

  def create
    @user = login(params[:email], params[:password], params[:remember])

    if @user
      redirect_back_or_to tracks_path, success: "ログインに成功しました" #t('.success')
    else
      flash.now[:danger] = "ログインに失敗しました" #t('.fail')
      render :new
    end
  end

  def destroy
    # ログアウト時にユーザのセッション情報を消す
    remember_me!
    forget_me!
    logout
    redirect_to root_url, success: "ログアウトに失敗しました" #t('.success')
  end
end
