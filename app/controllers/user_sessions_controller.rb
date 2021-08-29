class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_back_or_to tracks_path, success: "ログインに成功しました" #t('.success')
    else
      flash.now[:danger] = "ログインに失敗しました" #t('.fail')
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, success: "ログアウトに失敗しました" #t('.success')
  end
end
