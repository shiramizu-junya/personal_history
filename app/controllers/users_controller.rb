class UsersController < ApplicationController

  #  ユーザー新規作成画面
  def new
    @user = User.new
  end

  # ユーザー新規作成機能
  def create
    @user = User.new(user_params)

    if @user.save
      # ユーザー登録後の自動ログイン
      auto_login(@user)
      redirect_to tracks_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
